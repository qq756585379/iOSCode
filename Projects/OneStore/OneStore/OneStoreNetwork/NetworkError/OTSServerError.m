//
//  OTSServerError.m
//  OneStoreNetwork
//
//  Created by huangjiming on 4/12/16.
//  Copyright © 2016 OneStoreNetwork. All rights reserved.
//

#import "OTSServerError.h"
//define
#import "OTSFuncDefine.h"
//network
#import "OTSNetworkManager.h"
#import "OTSOperationManager.h"
//global
#import "OTSGlobalValue.h"
//cache
#import "OTSUserDefault.h"
#import "OTSConnectUrl.h"

#define IP_CACHE_TIME     14400               //缓存时间，单位秒，4小时

@interface OTSOperationParam ()

@property(nonatomic, copy) NSString *requestUrl;                        //请求url
@property(nonatomic, copy) NSString *usedIp;                            //记录当前请求使用的ip
@property(nonatomic, assign) BOOL needUseIp;                            //是否需要使用ip，默认为NO

@end

@interface OTSOperationManager ()

/**
 *  功能:服务器错误时将operation暂存
 */
- (void)cacheOperationForServerError:(OTSOperationParam *)aParam;

@end

@interface OTSNetworkManager ()

/**
 *  功能:更换ip后执行所有暂存的operation
 */
- (void)performAllCachedOperationsForServerError;

/**
 *  功能:更换ip仍然失败后清除所有暂存的operation
 */
- (void)clearAllCachedOperationsForServerError;

@end

@interface OTSServerError ()

@property(nonatomic, strong) OTSOperationManager *operationManger;
@property(nonatomic, strong) NSMutableArray *invalidIpArray;            //无效的ip列表

@end

@implementation OTSServerError

DEF_SINGLETON(OTSServerError)

#pragma mark - Property
- (NSString *)serverDomain
{
    if (_serverDomain == nil) {
        NSURL *defaultUrl = [NSURL URLWithString:[[OTSConnectUrl sharedInstance] getConnectUrlAddressWithType:OTSNetworkEnvironmentTypeProduct]];
        _serverDomain = defaultUrl.host;
    }
    return _serverDomain;
}

- (void)setServerIp:(NSString *)serverIp
{
    _serverIp = serverIp;
    _serverIpUseTime = [NSDate date];
    if (serverIp == nil) {
        [_invalidIpArray removeAllObjects];
    }
}

- (NSMutableArray *)invalidIpArray
{
    if (_invalidIpArray == nil) {
        _invalidIpArray = @[].mutableCopy;
    }
    return _invalidIpArray;
}

- (OTSOperationManager *)operationManger
{
    if (_operationManger == nil) {
        _operationManger = [[OTSNetworkManager sharedInstance] generateOperationMangerWithOwner:self];
    }
    return _operationManger;
}

#pragma mark - API
/**
 *  功能:当前错误是否是服务器错误的错误码
 */
- (BOOL)serverErrorForError:(NSError *)aError
                  withParam:(OTSOperationParam *)aParam
{
    NSURL *requestURL = [NSURL URLWithString:aParam.requestUrl];
    if (self.serverDomain.length>0 &&
        [requestURL.host isEqualToString:self.serverDomain]) {//只判断当前domain的请求
        if (aParam.usedIp.length > 0) {//使用ip之后出现的错误
            return YES;
        } else {//使用域名出现的错误
            NSError *underlyingError = [aError.userInfo objectForKey:@"NSUnderlyingError"];
            NSHTTPURLResponse *response = [underlyingError.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
            NSInteger statusCode = response.statusCode;
            if (statusCode>=500 && statusCode<600) {//5xx错误
                return YES;
            }
        }
    }
    
    return NO;
}

/**
 *  功能:服务器错误的错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError
{
    if (self.serverIp!=nil && ![self.serverIp isEqualToString:aParam.usedIp]) {//新老ip不一致
        //使用ip
        aParam.needUseIp = YES;
        //重新发起请求
        [aManager requestWithParam:aParam];
    } else {
        [aManager cacheOperationForServerError:aParam];
        
        if (!self.handling) {
            self.handling = YES;
            
            WEAK_SELF;
            [self p_getServerIpWithBlock:^(BOOL success) {
                STRONG_SELF;
                self.handling = NO;
                if (success) {
                    [[OTSNetworkManager sharedInstance] performAllCachedOperationsForServerError];
                } else {
                    [[OTSNetworkManager sharedInstance] clearAllCachedOperationsForServerError];
                }
            }];
        }
    }
    
    return NO;
}

/**
 *  功能:获取ip
 */
- (NSString *)getServerIp:(NSString *)requestUrl
{
    NSURL *requestURL = [NSURL URLWithString:requestUrl];
    if (self.serverDomain.length>0 &&
        [requestURL.host isEqualToString:self.serverDomain] &&
        self.serverIp.length>0 &&
        self.serverIpUseTime!=nil) {
        NSTimeInterval timeInterval = [self.serverIpUseTime timeIntervalSinceNow];
        BOOL expired = timeInterval<-IP_CACHE_TIME || timeInterval>0;
        if (!expired) {//未过期则使用ip替换域名，过期则还是使用域名
            return self.serverIp.mutableCopy;//记录当前请求使用的ip
        } else {
            self.serverIp = nil;
        }
    }
    return nil;
}

#pragma mark - Inner
/**
 *  功能:获取server ip
 */
- (void)p_getServerIpWithBlock:(OTSErrorHandleCompleteBlock)aBlock
{
    id ipListInfo = [[OTSUserDefault getValueForKey:@"DnsIpListInfo"] mutableCopy];
    BOOL useLocal = YES;
    if (![ipListInfo isKindOfClass:[NSMutableDictionary class]]) {
        useLocal = NO;
    } else {
        NSMutableDictionary *ipDict = ipListInfo;
        useLocal = [self p_getServerIpWithIpDict:ipDict block:aBlock];
    }
    
    if (!useLocal) {
        //获取ip列表
        WEAK_SELF;
        NSString *url = [NSString stringWithFormat:@"http://shangjia.yhd.com/d?dn=%@&t=3&r", self.serverDomain];
        OTSOperationParam *param = [OTSOperationParam paramWithUrl:url type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
            if (anError==nil && [aResponseObject isKindOfClass:[NSArray class]]) {
                STRONG_SELF;
                
                NSMutableArray *ipArray = [aResponseObject mutableCopy];
                if (ipArray.count > 0) {
                    u_int32_t randomIndex = arc4random() % [ipArray count];
                    NSString *randomIp = ipArray[randomIndex];
                    
                    NSMutableDictionary *serverIpDict = @{}.mutableCopy;
                    serverIpDict[@"ipList"] = [ipArray componentsJoinedByString:@","];
                    serverIpDict[@"currentIp"] = randomIp;
                    serverIpDict[@"cacheDate"] = [NSDate date];
                    [OTSUserDefault setValue:serverIpDict forKey:@"DnsIpListInfo"];
                    
                    [self p_getServerIpWithIpDict:serverIpDict block:aBlock];
                }
            }
        }];
        [self.operationManger requestWithParam:param];
    }
}

/**
 *  功能:获取server ip
 *  返回:是否获取到server ip
 */
- (BOOL)p_getServerIpWithIpDict:(NSMutableDictionary *)aIpDict
                          block:(OTSErrorHandleCompleteBlock)aBlock
{
    NSString *ipList = aIpDict[@"ipList"];
    NSString *currentIp = aIpDict[@"currentIp"];
    NSDate *cacheDate = aIpDict[@"cacheDate"];
    NSTimeInterval timeInterval = [cacheDate timeIntervalSinceNow];
    BOOL expired = timeInterval<-IP_CACHE_TIME || timeInterval>0;
    
    if (ipList.length>0 && currentIp.length>0 && !expired) {//数据有效
        if ([self.serverIp isEqualToString:currentIp]) {//当前ip无效，随机取下一个
            NSMutableArray *ipArray = [ipList componentsSeparatedByString:@","].mutableCopy;
            [self.invalidIpArray addObject:currentIp];
            [ipArray removeObjectsInArray:self.invalidIpArray];
            if (ipArray.count > 0) {
                u_int32_t randomIndex = arc4random() % [ipArray count];
                NSString *randomIp = ipArray[randomIndex];
                self.serverIp = randomIp;
            } else {//遍历完仍然有server error
                self.serverIp = nil;
            }
        } else {
            self.serverIp = currentIp;
        }
        
        //更新currentIp存入本地
        if (![aIpDict[@"currentIp"] isEqualToString:self.serverIp]) {
            aIpDict[@"currentIp"] = self.serverIp.mutableCopy;
            [OTSUserDefault setValue:aIpDict forKey:@"DnsIpListInfo"];
        }
        
        //回调
        if (aBlock) {
            aBlock(self.serverIp!=nil);
        }
        
        return YES;
    } else {
        return NO;
    }
}

@end
