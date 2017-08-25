//
//  OTSOperationManager.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSOperationManager.h"
#import "OTSURLCache.h"
#import "OTSWeakObjectDeathNotifier.h"
#import "OTSNetworkQuery.h"
#import "OTSNetworkError.h"
#import "OTSLaunchFailError.h"
#import "OTSReachability.h"
#import "OTSWebView.h"
#import "OTSServerError.h"
#import "OTSClientInfo.h"
#import "OTSNetworkCommonError.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "OTSBatchOperaionParam.h"
#import "OTSCurrentAddress.h"

@interface OTSOperationManager()
@property(nonatomic, strong) NSMutableArray *operationParams;//这里记录operation param，防止其释放，token过期处理会用到operation param
@property(nonatomic, strong) NSMutableArray *batchOperationParams;//批量处理operation param
@property(nonatomic, strong) NSMutableArray *cachedParamsForTokenExpire;//token过期时缓存的所有operation param
@property(nonatomic, strong) NSMutableArray *cachedParamsForSignKeyExpire;//密钥过期时缓存的所有operation param
@property(nonatomic, strong) NSMutableArray *cachedParamsForLaunchFail;//launch接口调用失败时缓存的所有operation param
@property(nonatomic, strong) NSMutableArray *cachedParamsForShowErrorView;//为错误界面缓存的所有operation param
@property(nonatomic, strong) NSMutableArray *cachedParamsForServerError;//为服务器错误缓存的所有operation param
@property(nonatomic, assign) BOOL sessionIsInvalid;//session是否无效
@end

@implementation OTSOperationManager

+ (instancetype)manager{
    return [self managerWithOwner:nil];
}

+ (instancetype)managerWithOwner:(id)owner{
    OTSOperationManager *operationManager = [super manager];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"application/javascript", @"text/plain", @"text/json", @"application/x-javascript", nil];
    operationManager.hostClassName = NSStringFromClass([owner class]);
    
    if (owner) {
        OTSWeakObjectDeathNotifier *wo = [OTSWeakObjectDeathNotifier new];
        [wo setOwner:owner];
        [wo setBlock:^(OTSWeakObjectDeathNotifier *sender) {
            [operationManager cancelOperationsAndRemoveFromNetworkManager];
        }];
    }
    
    //缓存策略
    operationManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    static dispatch_once_t onceTokenInManager;
    dispatch_once(&onceTokenInManager, ^{
        [NSURLCache setSharedURLCache:[OTSURLCache standardURLCache]];
    });
    
    //query格式
    [operationManager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return [OTSNetworkQuery queryStringFromParameters:parameters encoding:NSUTF8StringEncoding];;
    }];
    
    //session无效
    __weak OTSOperationManager *weakManager = operationManager;
    [operationManager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        __strong OTSOperationManager *strongManager = weakManager;
        strongManager.sessionIsInvalid = YES;
    }];
    return operationManager;
}

#pragma mark - API
/**
 *  功能:发送请求
 */
- (NSURLSessionDataTask *)requestWithParam:(OTSOperationParam *)aParam{
    if (aParam == nil) {
        return nil;
    }
    //session无效
    if (self.sessionIsInvalid) {
        NSLog(@"{method name}: %@\n\nerror:\nsession invalid\n", aParam.methodName);
        NSLog(@"(%lld)接口session invalid\n接口名%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl);
        [self performInMainThreadBlock:^{
            NSError *error = [NSError errorWithDomain:@"session invalid" code:kSessionInvalid userInfo:nil];
            if (aParam.isNeedRacRequest) {
                [aParam.subscriber sendError:error];
            } else if (aParam.callbackBlock) {
                aParam.callbackBlock(nil, error);
            }
            [self.operationParams removeObject:aParam];
        }];
        return nil;
    }
    
    //启动接口调用失败
    if (aParam.needSignature && [OTSGlobalValue sharedInstance].signatureKey==nil) {
        BOOL runCallBack = [[OTSLaunchFailError sharedInstance] dealWithManager:self param:aParam operation:nil responseObject:nil error:nil];
        if (runCallBack) {
            NSLog(@"{method name}: %@\n\nerror:\nlaunch fail\n", aParam.methodName);
            NSLog(@"(%lld)接口launch fail\n接口名%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl);
            [self performInMainThreadBlock:^{
                NSError *error = [NSError errorWithDomain:@"launch fail" code:kLaunchFail userInfo:nil];
                if (aParam.isNeedRacRequest) {
                    [aParam.subscriber sendError:error];
                } else if (aParam.callbackBlock) {
                    aParam.callbackBlock(nil, error);
                }
                [self.operationParams removeObject:aParam];
            }];
        }
        return nil;
    }
    
    //将operation param加入数组，便于管理
    [self.operationParams safeAddObject:aParam];
    
    //requestSerializer处理
    [self modifyRequestSerializerWithParam:aParam];
    
    //cookie
    if (aParam.needCooike) {
        [OTSWebView setupDefaultCookies];
    }
    
    //业务参数组装
    NSMutableDictionary *params = aParam.requestParam.mutableCopy;
    if (aParam.needSignature) {//需要签名
        NSString *timeStamp = [self getServerTimeStamp];
        NSString *signature = [self getSignature:aParam.requestParam timeStamp:timeStamp];
        [params safeSetObject:@"md5" forKey:@"signature_method"];
        [params safeSetObject:timeStamp forKey:@"timestamp"];
        [params safeSetObject:signature forKey:@"signature"];
    }
    [params safeSetObject:[OTSClientInfo sharedInstance].traderName forKey:@"trader"];
    
    //http dns
    NSString *requestUrl = aParam.requestUrl;
    if (aParam.needUseIp) {
        //替换ip
        NSString *currentDomain = [OTSServerError sharedInstance].serverDomain;
        NSString *replaceServerIp = [[OTSServerError sharedInstance] getServerIp:aParam.requestUrl];
        if (currentDomain.length>0 && replaceServerIp.length>0) {
            requestUrl = [requestUrl stringByReplacingOccurrencesOfString:currentDomain withString:replaceServerIp];
        }
        //重置是否使用ip
        aParam.needUseIp = NO;
        //记录使用ip
        aParam.usedIp = replaceServerIp;
    }
    
    //接口请求
    NSURLSessionDataTask *requestOperation = nil;
    WEAK_SELF;
    if (aParam.requestType == kRequestPost) {//POST方式
        requestOperation = [self POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF;
            [self successWithTask:task responseObject:responseObject param:aParam];
            NSLog(@"(%lld)接口返回成功\n\n接口名%@\n接口内容%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF;
            [self failWithTask:task error:error param:aParam];
            NSLog(@"(%lld)接口返回失败\n接口名%@\n错误信息%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl, error);
        }];
    } else {
        requestOperation = [self POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF;
            [self successWithTask:task responseObject:responseObject param:aParam];
            NSLog(@"(%lld)接口返回成功\n接口名%@\n接口内容%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF;
            [self failWithTask:task error:error param:aParam];
            NSLog(@"(%lld)接口返回失败\n接口名%@\n错误信息%@\n\n", (long long)([[OTSGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000), aParam.requestUrl, error);
        }];
    }
    
    //记录当前使用的token，便于token过期的判断处理
    aParam.usedToken = [OTSGlobalValue sharedInstance].token;
    
    //记录接口开始调用时间，便于统计接口耗时
    aParam.startTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    
    //打印Request
    [self printRequest:aParam operation:requestOperation];
    
    return requestOperation;
}

/**
 *  发送网络请求，创建信号
 */
- (RACSignal *)rac_requestWithParam:(OTSOperationParam *)aParam{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        aParam.subscriber = subscriber;
        aParam.isNeedRacRequest = YES;
        NSURLSessionDataTask *task = [self requestWithParam:aParam];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

/**
 *  功能:取消当前manager queue中所有网络请求
 */
- (void)cancelAllOperations{
    NSArray *tasks = self.tasks.copy;
    for (NSURLSessionDataTask *task in tasks) {
        [task cancel];
    }
    
    //call back block置空
    for (OTSOperationParam *operationParam in self.operationParams.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.operationParams removeAllObjects];
    
    for (OTSBatchOperaionParam *batch in self.batchOperationParams.copy) {
        batch.completeBlock = nil;
    }
    [self.batchOperationParams removeAllObjects];
    
    for (OTSOperationParam *operationParam in self.cachedParamsForTokenExpire.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.cachedParamsForTokenExpire removeAllObjects];
    
    for (OTSOperationParam *operationParam in self.cachedParamsForSignKeyExpire.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.cachedParamsForSignKeyExpire removeAllObjects];
    
    for (OTSOperationParam *operationParam in self.cachedParamsForLaunchFail.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.cachedParamsForLaunchFail removeAllObjects];
    
    for (OTSOperationParam *operationParam in self.cachedParamsForShowErrorView.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.cachedParamsForShowErrorView removeAllObjects];
    
    for (OTSOperationParam *operationParam in self.cachedParamsForServerError.copy) {
        operationParam.callbackBlock = nil;
        operationParam.retryTimes = 0;
    }
    [self.cachedParamsForServerError removeAllObjects];
}

#pragma mark - Success & Fail
/**
 *  功能:接口调用成功处理
 */
- (void)successWithTask:(NSURLSessionDataTask *)task
         responseObject:(id)responseObject
                  param:(OTSOperationParam *)aParam{
    //兼容接口返回的数组类型数据
    if ([responseObject isKindOfClass:[NSArray class]]) {
        NSMutableDictionary *responseDict = @{}.mutableCopy;
        responseDict[@"rtn_code"] = @"0";
        responseDict[@"data"] = responseObject;
        responseObject = responseDict;
    }
    
    //打印成功的Response
    [self printSuccessResponse:aParam responseObject:responseObject];
    //统计日志上传
    [self uploadLog:aParam responseObject:responseObject];
    //错误处理(错误提示、token过期、密钥过期、删除缓存)
    BOOL runCallBack = [[OTSNetworkCommonError sharedInstance] dealWithManager:self param:aParam operation:task responseObject:responseObject error:nil];
    //回调
    if (runCallBack) {
        //数据的二次加工
        id data = [responseObject safeObjectForKey:@"data"];
        NSString *rtnCode = [responseObject safeObjectForKey:@"rtn_code"];
        NSString *rtn_tip = [responseObject safeObjectForKey:@"rtn_tip"];
        NSString *rtn_msg = [responseObject safeObjectForKey:@"rtn_msg"];
        
        NSError *error = nil;
        //rtn_code不为0时，将aResponseObject作为error的userInfo传过去
        if (rtnCode.length>0 && ![rtnCode isEqualToString:@"0"]) {
            NSString *msg = rtn_tip;
            if (!msg || [msg isEqualToString:@""]) {
                msg = rtn_msg;
            }
            msg = msg ? msg : @"";
            NSMutableDictionary *userInfo = [responseObject mutableCopy];
            userInfo[NSLocalizedDescriptionKey] = msg;
            error = [NSError errorWithDomain:OTSInterfaceReturnErrorDomain code:kReturnCodeNotEqualToZero userInfo:[userInfo copy]];
        }
        if (error) {
            if (aParam.isNeedRacRequest) {
                if (!aParam.blockSendError) {
                    [aParam.subscriber sendError:error];
                }
            } else if (aParam.callbackBlock) {
                aParam.callbackBlock(nil, error);
            }
        } else {
            if (aParam.isNeedRacRequest) {
                [aParam.subscriber sendNext:data];
                [aParam.subscriber sendCompleted];
            } else if (aParam.callbackBlock) {
                aParam.callbackBlock(data, nil);
            }
        }
    }
    
    [self.operationParams removeObject:aParam];
}

/**
 *  功能:接口调用失败处理
 */
- (void)failWithTask:(NSURLSessionDataTask *)task
               error:(NSError *)aError
               param:(OTSOperationParam *)aParam{
    //打印失败的日志
    [self printFailResponse:aParam error:aError];
    //错误处理(错误提示、token过期、密钥过期、删除缓存)
    BOOL serverError = [[OTSServerError sharedInstance] serverErrorForError:aError withParam:aParam];
    BOOL runCallBack = [[OTSNetworkCommonError sharedInstance] dealWithManager:self param:aParam operation:task responseObject:nil error:aError];
    //回调
    if (runCallBack ) {
        if (aParam.isNeedRacRequest) {
            if (!aParam.blockSendError) {
                [aParam.subscriber sendError:aError];
            }
        } else if (aParam.callbackBlock) {
            aParam.callbackBlock(nil, aError);
        }
    }
    
    if (serverError || aParam.retryTimes<=0) {
        [self.operationParams removeObject:aParam];
    } else {
        //接口重试
        aParam.retryTimes --;
        [self requestWithParam:aParam];
    }
}

#pragma mark -- Inner
/**
 *  功能:修改RequestSerializer
 */
- (void)modifyRequestSerializerWithParam:(OTSOperationParam *)aParam{
    //超时时间
    self.requestSerializer.timeoutInterval = aParam.timeoutTime;
    //Cache-control(缓存时间)
    [self.requestSerializer setValue:[NSString stringWithFormat:@"max-age=%.0f", aParam.cacheTime] forHTTPHeaderField:@"Cache-control"];
    
    //User-Agent
    NSString *userAgent = [NSString stringWithFormat:@"yhd-%@-%@-%@-(%@; iOS %@)", (IS_IPAD_DEVICE ? @"ipad": @"iphone"), ([[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ? : [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey]), ([[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ? : [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey]), [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
    [self.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    //Content-Type
    if (aParam.requestType == kRequestPost) {
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    } else {
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type"];
    }
    
    //clientInfo
    NSString *clientInfo = [[OTSClientInfo sharedInstance] toJSONString];
    [self.requestSerializer setValue:clientInfo forHTTPHeaderField:@"clientInfo"];
    
    //userToken
    NSString *token = aParam.needEncoderToken ? [self getAesEncodedToken] : [OTSGlobalValue sharedInstance].token;
    [self.requestSerializer setValue:token forHTTPHeaderField:@"userToken"];
    
    //provinceId
    NSString *provinceId = [NSString stringWithFormat:@"%@", [OTSCurrentAddress sharedInstance].currentProvinceId];
    [self.requestSerializer setValue:provinceId forHTTPHeaderField:@"provinceId"];
    
    //cityId
    NSString *cityId = [NSString stringWithFormat:@"%@", [OTSCurrentAddress sharedInstance].currentCityId];
    [self.requestSerializer setValue:cityId forHTTPHeaderField:@"cityId"];
    
    //dns
    NSString *requestUrl = aParam.requestUrl;
    NSString *currentDomain = [OTSServerError sharedInstance].serverDomain;
    if ([requestUrl safeRangeOfString:currentDomain].location != NSNotFound) {
        NSURL *url = [NSURL URLWithString:requestUrl];
        [self.requestSerializer setValue:url.host forHTTPHeaderField:@"Host"];
    } else {
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Host"];
    }
}

/**
 *  功能:获取签名字符串
 */
- (NSString *)getSignature:(NSDictionary *)aDict timeStamp:(NSString *)aTimeStamp{
    NSMutableDictionary *theDict = [aDict mutableCopy];
    //signature_method
    [theDict safeSetObject:@"md5" forKey:@"signature_method"];
    //timestamp
    [theDict safeSetObject:aTimeStamp forKey:@"timestamp"];
    //trader
    [theDict safeSetObject:[OTSClientInfo sharedInstance].traderName forKey:@"trader"];
    
    //拼装
    NSMutableString *mString = [NSMutableString string];
    NSArray *queryPairs = [OTSNetworkQuery queryPairsFromDictionary:theDict];
    NSArray *sortedQueryPairs = [queryPairs sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (OTSQueryPair *queryPair in sortedQueryPairs) {
        [mString safeAppendString:[queryPair queryString]];
    }
    
    //加上私钥
    NSString *signatureKey = [OTSGlobalValue sharedInstance].signatureKey;
    [mString safeAppendString:signatureKey];
    
    //md5运算
    NSString *signature = [mString stringFromMD5];
    signature = [signature uppercaseString];
    
    return signature;
}

/**
 *  功能:获取服务器时间戳
 */
- (NSString *)getServerTimeStamp{
    NSTimeInterval dTime = [OTSGlobalValue sharedInstance].dTime;//服务器时间-本地时间
    NSTimeInterval serverTimeStamp = [[NSDate date] timeIntervalSince1970] + dTime;
    NSString *serverTimeStampStr = [NSString stringWithFormat:@"%0.0lf", serverTimeStamp];
    return serverTimeStampStr;
}

/**
 *  功能:获取AES加密的token
 */
- (NSString *)getAesEncodedToken{
    NSString *token = [OTSGlobalValue sharedInstance].token;
    if (token == nil) {
        return nil;
    }
    
    // 接口要求毫秒数
    long long time = [[self getServerTimeStamp] longLongValue];
    NSString *totalStr = [NSString stringWithFormat:@"%@::%lld", token, time * 1000];
    NSString *signatureKey = [OTSGlobalValue sharedInstance].signatureKey;
    NSError *error = nil;
    NSString *encodedStr = [totalStr encryptByAESKey:signatureKey error:&error];
    return encodedStr;
}

/**
 *  功能:取消当前manager queue中所有网络请求，并从network manager中移除
 */
- (void)cancelOperationsAndRemoveFromNetworkManager{
    [self cancelAllOperations];
    [self invalidateSessionCancelingTasks:YES];
    [[OTSNetworkManager sharedInstance] removeOperationManger:self];
}

#pragma mark - 打印Request & Response
/**
 *  打印Request，主要是接口请求的参数描述
 */
- (void)printRequest:(OTSOperationParam *)aParam
           operation:(NSURLSessionDataTask *)requestOperation{
#ifdef DEBUG
    NSURLRequest *request = [requestOperation currentRequest];
    NSString *unEncodeUrl = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSTimeInterval dTime = [OTSGlobalValue sharedInstance].dTime;//服务器时间-本地时间
    NSTimeInterval serverTimeStamp = [[NSDate date] timeIntervalSince1970] + dTime;
    NSDate *localDate = [NSDate date];
    NSDate *serverDate = [NSDate dateWithTimeIntervalSince1970:serverTimeStamp];
    OTSLogV(@"{method name}: %@\n\n{method params}:  %@\n\n{url before encode}:\n%@\n\n{signature key before encode}:\n%@\n\n{token before encode}:\n%@\n\n{local time}:%@\n\n{d time}:%f\n\n{server time}:%@\n\n{used ip}:%@\n\n{global ip}:%@\n", aParam.methodName,  aParam.requestParam, unEncodeUrl, [OTSGlobalValue sharedInstance].signatureKey, [OTSGlobalValue sharedInstance].token, localDate, dTime, serverDate, aParam.usedIp, [OTSServerError sharedInstance].serverIp);
#endif
}

/**
 *  打印成功的Response
 */
- (void)printSuccessResponse:(OTSOperationParam *)aParam
              responseObject:(id)aResponseObject{
#ifdef DEBUG
    NSString *description = [aResponseObject description];
    if (description) {
        description = [NSString unicodeToUtf8:description];
    }
    
    if (description && description.length > 0) {
        OTSLogV(@"{method name}: %@\n\n{response}:\n%@\n", aParam.methodName, description);
    } else {
        OTSLogV(@"{method name}: %@\n\n{response}:\n%@\n", aParam.methodName, aResponseObject);
    }
#endif
}

/**
 *  打印失败的Response
 */
- (void)printFailResponse:(OTSOperationParam *)aParam
                    error:(NSError *)aError{
#ifdef DEBUG
    NSString *errorMessage = [aError description];
    if (errorMessage) {
        errorMessage = [NSString unicodeToUtf8:errorMessage];
    }
    if (errorMessage && errorMessage.length > 0) {
        OTSLogV(@"{method name}: %@\n\nerror:\n%@\n", aParam.methodName,errorMessage);
    } else {
        OTSLogV(@"{method name}: %@\n\nerror:\n%@\n", aParam.methodName, aError);
    }
#endif
}

#pragma mark - 接口日志上传
/**
 *  接口日志上传
 */
- (void)uploadLog:(OTSOperationParam *)aParam responseObject:(id)aResponseObject{
    aParam.endTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *rtnCode = [aResponseObject safeObjectForKey:@"rtn_code"];
    if ([rtnCode isEqualToString:@"0"]) {
        [[OTSNetworkLog sharedInstance] saveLogWithParam:aParam];
        [[OTSNetworkLog sharedInstance] sendLog];
    }
}

#pragma mark - Token Expire
/**
 *  功能:token过期时将operation暂存
 */
- (void)cacheOperationForTokenExpire:(OTSOperationParam *)aParam{
    if (!aParam.rerunForTokenExpire) {
        [self.cachedParamsForTokenExpire safeAddObject:aParam];
    }
}

/**
 *  功能:登录成功后执行所有暂存的operation
 */
- (void)performCachedOperationsForTokenExpire{
    NSArray *copyArray = self.cachedParamsForTokenExpire.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForTokenExpire) {
            param.rerunForTokenExpire = YES;
            [self requestWithParam:param];
        }
    }
    [self.cachedParamsForTokenExpire removeAllObjects];
}

/**
 *  功能:登录失败后清除所有暂存的operation
 */
- (void)clearCachedOperationsForTokenExpire{
    //清除之前先执行call back
    NSArray *copyArray = self.cachedParamsForTokenExpire.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForTokenExpire) {
            param.rerunForTokenExpire = YES;
            //回调
            if (param.callbackBlock) {
                NSError *error = [NSError errorWithDomain:@"login fail when token expire" code:kLoginFailWhenTokenExpire userInfo:nil];
                param.callbackBlock(nil, error);
            }
        }
        //发通知显示错误界面
        [self notifyShowErrorWithParam:param];
    }
    
    [self.cachedParamsForTokenExpire removeAllObjects];
}

#pragma mark - Sign Key Expire
/**
 *  功能:密钥过期时将operation暂存
 */
- (void)cacheOperationForSignKeyExpire:(OTSOperationParam *)aParam{
    if (!aParam.rerunForSignKeyExpire) {
        [self.cachedParamsForSignKeyExpire safeAddObject:aParam];
    }
}

/**
 *  功能:获取密钥接口成功后执行所有暂存的operation
 */
- (void)performCachedOperationsForSignKeyExpire{
    NSArray *copyArray = self.cachedParamsForSignKeyExpire.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForSignKeyExpire) {
            param.rerunForSignKeyExpire = YES;
            [self requestWithParam:param];
        }
    }
    [self.cachedParamsForSignKeyExpire removeAllObjects];
}

/**
 *  功能:获取密钥接口失败后清除所有暂存的operation
 */
- (void)clearCachedOperationsForSignKeyExpire{
    //清除之前先执行call back
    NSArray *copyArray = self.cachedParamsForSignKeyExpire.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForSignKeyExpire) {
            param.rerunForSignKeyExpire = YES;
            //回调
            if (param.callbackBlock) {
                NSError *error = [NSError errorWithDomain:@"get sign key fail when sign key expire" code:kGetSignKeyFailWhenSignKeyExpire userInfo:nil];
                param.callbackBlock(nil, error);
            }
        }
        
        //发通知显示错误界面
        [self notifyShowErrorWithParam:param];
    }
    
    [self.cachedParamsForSignKeyExpire removeAllObjects];
}

#pragma mark - Launch Fail
/**
 *  功能:launch接口调用失败时将operation暂存
 */
- (void)cacheOperationForLaunchFail:(OTSOperationParam *)aParam{
    if (!aParam.rerunForLaunchFail) {
        [self.cachedParamsForLaunchFail safeAddObject:aParam];
    }
}

/**
 *  功能:relaunch成功后执行所有暂存的operation
 */
- (void)performCachedOperationsForLaunchFail{
    NSArray *copyArray = self.cachedParamsForLaunchFail.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForLaunchFail) {
            param.rerunForLaunchFail = YES;
            [self requestWithParam:param];
        }
    }
    [self.cachedParamsForLaunchFail removeAllObjects];
}

/**
 *  功能:relaunch失败后清除所有暂存的operation
 */
- (void)clearCachedOperationsForLaunchFail{
    //清除之前先执行call back
    NSArray *copyArray = self.cachedParamsForLaunchFail.copy;
    for (OTSOperationParam *param in copyArray) {
        if (!param.rerunForLaunchFail) {
            param.rerunForLaunchFail = YES;
            //回调
            if (param.callbackBlock) {
                NSError *error = [NSError errorWithDomain:@"launch fail" code:kLaunchFail userInfo:nil];
                param.callbackBlock(nil, error);
            }
        }
        
        //发通知显示错误界面
        [self notifyShowErrorWithParam:param];
    }
    
    [self.cachedParamsForLaunchFail removeAllObjects];
}

#pragma mark - Show Error View
/**
 *  功能:发notification，显示错误界面
 */
- (void)notifyShowErrorWithParam:(OTSOperationParam *)aParam{
    if (aParam.showErrorView) {//显示错误界面
        aParam.blockSendError = YES;
        [self performInMainThreadBlock:^{
            //缓存所有出错接口
            [self.cachedParamsForShowErrorView safeAddObject:aParam];
            @try {
                [[NSNotificationCenter defaultCenter] postNotificationName:OTS_SHOW_ERROR_VIEW object:self userInfo:nil];
            }@catch (NSException *exception) {}
            @finally {}
        }];
    }
}

/**
 *  功能:发notification，隐藏无网络错误界面
 */
- (void)notifyHideNoConnectError{
    //有网络，则隐藏无网络错误界面
    if ([OTSReachability sharedInstance].currentNetStatus != kConnectToNull) {
        [self performInMainThreadBlock:^{
            @try {
                [[NSNotificationCenter defaultCenter] postNotificationName:OTS_HIDE_NO_CONNECT_ERROR_VIEW object:self userInfo:nil];
            }
            @catch (NSException *exception) {}
            @finally {}
        }];
    }
}

/**
 *  功能:执行错误界面缓存的operation
 */
- (void)performCachedOperationForShowErrorView{
    NSArray *copyArray = self.cachedParamsForShowErrorView.copy;
    for (OTSOperationParam *param in copyArray) {
        [self requestWithParam:param];
    }
    [self.cachedParamsForShowErrorView removeAllObjects];
}

#pragma mark - Server Error
/**
 *  功能:服务器错误时将operation暂存
 */
- (void)cacheOperationForServerError:(OTSOperationParam *)aParam{
    [self.cachedParamsForServerError safeAddObject:aParam];
}

/**
 *  功能:服务器错误更换ip后执行所有暂存的operation
 */
- (void)performCachedOperationsForServerError{
    NSArray *copyArray = self.cachedParamsForServerError.copy;
    for (OTSOperationParam *param in copyArray) {
        param.needUseIp = YES;//使用ip
        [self requestWithParam:param];
    }
    [self.cachedParamsForServerError removeAllObjects];
}

/**
 *  功能:更换ip仍然失败后清除所有暂存的operation
 */
- (void)clearCachedOperationsForServerError{
    //清除之前先执行call back
    NSArray *copyArray = self.cachedParamsForServerError.copy;
    for (OTSOperationParam *param in copyArray) {
        //重置是否使用ip
        param.needUseIp = NO;
        //重置使用的ip
        param.usedIp = nil;
        //回调
        if (param.callbackBlock) {
            NSError *error = [NSError errorWithDomain:@"request fail when change ip for server error"
                                                 code:kChangeIpForServerError userInfo:nil];
            param.callbackBlock(nil, error);
        }
        //发通知显示错误界面
        [self notifyShowErrorWithParam:param];
    }
    [self.cachedParamsForServerError removeAllObjects];
}

#pragma mark - Property
- (NSMutableArray *)operationParams{
    if (_operationParams == nil) {
        _operationParams = @[].mutableCopy;
    }
    return _operationParams;
}

- (NSMutableArray *)batchOperationParams{
    if (_batchOperationParams == nil) {
        _batchOperationParams = @[].mutableCopy;
    }
    return _batchOperationParams;
}

- (NSMutableArray *)cachedParamsForTokenExpire{
    if (_cachedParamsForTokenExpire == nil) {
        _cachedParamsForTokenExpire = @[].mutableCopy;
    }
    return _cachedParamsForTokenExpire;
}

- (NSMutableArray *)cachedParamsForSignKeyExpire{
    if (_cachedParamsForSignKeyExpire == nil) {
        _cachedParamsForSignKeyExpire = @[].mutableCopy;
    }
    return _cachedParamsForSignKeyExpire;
}

- (NSMutableArray *)cachedParamsForLaunchFail{
    if (_cachedParamsForLaunchFail == nil) {
        _cachedParamsForLaunchFail = @[].mutableCopy;
    }
    return _cachedParamsForLaunchFail;
}

- (NSMutableArray *)cachedParamsForShowErrorView{
    if (_cachedParamsForShowErrorView == nil) {
        _cachedParamsForShowErrorView = @[].mutableCopy;
    }
    return _cachedParamsForShowErrorView;
}

- (NSMutableArray *)cachedParamsForServerError{
    if (_cachedParamsForServerError == nil) {
        _cachedParamsForServerError = @[].mutableCopy;
    }
    return _cachedParamsForServerError;
}

- (void)dealloc{
    NSLog(@"[%@ call %@ --> %@]", [self class], NSStringFromSelector(_cmd), _hostClassName);
}

@end








