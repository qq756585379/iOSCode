//
//  OTSSignKeyExpireError.m
//  OneStoreFramework
//
//  Created by huangjiming on 9/19/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSSignKeyExpireError.h"
#import "OTSNetworkManager.h"
//category
#import "NSMutableArray+safe.h"
//define
#import "OTSFuncDefine.h"
//network
#import "OTSOperationManager.h"

@interface OTSOperationParam ()

@property(nonatomic, assign) BOOL rerunForSignKeyExpire;                //是否重新调用获取密钥接口后再次执行，默认为NO

@end

@interface OTSOperationManager()

/**
 *  功能:密钥过期时将operation暂存
 */
- (void)cacheOperationForSignKeyExpire:(OTSOperationParam *)aParam;

@end

@interface OTSNetworkManager()

/**
 *  功能:获取密钥成功后执行所有暂存的operation
 */
- (void)performAllCachedOperationsForSignKeyExpire;

/**
 *  功能:获取密钥失败后清除所有暂存的operation
 */
- (void)clearAllCachedOperationsForSignKeyExpire;

@end

@interface OTSSignKeyExpireError()

@property(nonatomic, strong) NSMutableArray *signKeyExpireRtnCodes;//所有密钥过期错误码,list<NSString>类型

@end

@implementation OTSSignKeyExpireError

DEF_SINGLETON(OTSSignKeyExpireError)

- (NSMutableArray *)signKeyExpireRtnCodes
{
    if (_signKeyExpireRtnCodes == nil) {
        _signKeyExpireRtnCodes = [NSMutableArray array];
    }
    return _signKeyExpireRtnCodes;
}

/**
 *  功能:添加密钥过期rtn_code
 */
- (void)addSignKeyExpireRtnCode:(NSString *)aRtnCode
{
    [self.signKeyExpireRtnCodes safeAddObject:aRtnCode];
}

/**
 *  功能:aRtnCode是否是密钥过期错误码
 */
- (BOOL)signKeyExpiredForRtnCode:(NSString *)aRtnCode
{
    for (NSString *rtnCode in self.signKeyExpireRtnCodes) {
        if ([rtnCode isEqualToString:aRtnCode]) {
            return YES;
        }
    }
    return NO;
}

/**
 *  功能:密钥过期的错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError
{
    if (aParam.rerunForSignKeyExpire) {
        return YES;
    }
    
    [aManager cacheOperationForSignKeyExpire:aParam];
    
    if (!self.handling && self.errorHandleBlock != nil) {
        self.handling = YES;
        WEAK_SELF;
        self.errorHandleBlock(^(BOOL success) {
            STRONG_SELF;
            self.handling = NO;
            if (success) {
                [[OTSNetworkManager sharedInstance] performAllCachedOperationsForSignKeyExpire];
            } else {
                [[OTSNetworkManager sharedInstance] clearAllCachedOperationsForSignKeyExpire];
            }
        });
    }
    
    return NO;
}

@end
