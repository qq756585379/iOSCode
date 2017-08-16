//
//  OTSLaunchFailError.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLaunchFailError.h"
#import "OTSOperationManager.h"
#import "OTSNetworkManager.h"

@implementation OTSLaunchFailError

DEF_SINGLETON(OTSLaunchFailError)

/**
 *  功能:启动接口调用失败的错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError{
    if (aParam.rerunForLaunchFail) {
        return YES;
    }
    
    [aManager cacheOperationForLaunchFail:aParam];
    
    if (!self.handling && self.errorHandleBlock != nil) {
        self.handling = YES;
        WEAK_SELF;
        self.errorHandleBlock(^(BOOL success) {
            STRONG_SELF;
            self.handling = NO;
            if (success) {
                [[OTSNetworkManager sharedInstance] performAllCachedOperationsForLaunchFail];
            } else {
                [[OTSNetworkManager sharedInstance] clearAllCachedOperationsForLaunchFail];
            }
        });
    }
    
    return NO;
}

@end
