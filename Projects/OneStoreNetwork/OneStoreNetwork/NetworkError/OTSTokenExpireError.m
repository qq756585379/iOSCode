//
//  OTSTokenExpireError.m
//  OneStoreFramework
//
//  Created by huang jiming on 14-8-7.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSTokenExpireError.h"
#import "OTSNetworkManager.h"
//define
#import "OTSFuncDefine.h"
//network
#import "OTSOperationManager.h"
//global
#import "OTSGlobalValue.h"

@interface OTSOperationParam ()

@property(nonatomic, assign) BOOL rerunForTokenExpire;                  //是否token过期自动登录后再次执行，默认为NO
@property(nonatomic, copy) NSString *usedToken;                         //记录当前请求使用的token

@end

@interface OTSOperationManager()

/**
 *  功能:token过期时将operation暂存
 */
- (void)cacheOperationForTokenExpire:(OTSOperationParam *)aParam;

@end

@interface OTSNetworkManager()

/**
 *  功能:登录成功后执行所有暂存的operation
 */
- (void)performAllCachedOperationsForTokenExpire;

/**
 *  功能:登录失败后清除所有暂存的operation
 */
- (void)clearAllCachedOperationsForTokenExpire;

@end

@interface OTSTokenExpireError()

@property(nonatomic, strong) NSMutableSet *tokenExpireRtnCodes;//所有token过期错误码,set<NSString>类型

@end

@implementation OTSTokenExpireError

DEF_SINGLETON(OTSTokenExpireError)

- (NSMutableSet *)tokenExpireRtnCodes
{
    if (_tokenExpireRtnCodes == nil) {
        _tokenExpireRtnCodes = [NSMutableSet set];
    }
    return _tokenExpireRtnCodes;
}

/**
 *  功能:添加token过期rtn_code
 */
- (void)addTokenExpireRtnCode:(NSString *)aRtnCode
{
    [self.tokenExpireRtnCodes addObject:aRtnCode];
}

/**
 *  功能:aRtnCode是否是token过期错误码
 */
- (BOOL)tokenExpiredForRtnCode:(NSString *)aRtnCode
{
    if([self.tokenExpireRtnCodes containsObject:aRtnCode]) {
        return YES;
    } 
    return NO;
}

/**
 *  功能:token过期的错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError
{
    if (aParam.rerunForTokenExpire) {
        return YES;
    }
    
    if (![aParam.usedToken isEqualToString:[OTSGlobalValue sharedInstance].token]) {//新老token不一致
        aParam.rerunForTokenExpire = YES;
        [aManager requestWithParam:aParam];
    } else {
        [aManager cacheOperationForTokenExpire:aParam];
        
        if (!self.handling && self.errorHandleBlock != nil) {
            self.handling = YES;
            WEAK_SELF;
            self.errorHandleBlock(^(BOOL success) {
                STRONG_SELF;
                self.handling = NO;
                if (success) {
                    [[OTSNetworkManager sharedInstance] performAllCachedOperationsForTokenExpire];
                } else {
                    [[OTSNetworkManager sharedInstance] clearAllCachedOperationsForTokenExpire];
                }
            });
        }
    }
    
    return NO;
}

@end
