//
//  OTSNetworkError.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSNetworkError.h"

NSString *const OTSInterfaceReturnErrorDomain = @"InterfaceReturnError";

@implementation OTSNetworkError

/**
 *  功能:错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError{
    return YES;
}

@end
