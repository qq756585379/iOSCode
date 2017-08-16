//
//  OTSNetworkError.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OTSOperationManager, OTSOperationParam;

typedef enum {
    kLaunchFail = 1,                    //启动接口调用失败
    kLoginFailWhenTokenExpire,          //token过期后自动登录失败
    kGetSignKeyFailWhenSignKeyExpire,   //密钥过期后重新获取密钥失败
    kReturnCodeNotEqualToZero,          //rtn_code不为0
    kDataTypeMismatch,                  // 数据类型不匹配
    kChangeIpForServerError,            //服务器5xx错误后更换ip后仍然失败
    kSessionInvalid,                    //session无效
    kNotConnectToServer = -1004,        //网络连接错误
    kServerError = -1011,               //服务器错误
} ENetworkError;

UIKIT_EXTERN NSString *const OTSInterfaceReturnErrorDomain;

typedef void(^OTSErrorHandleCompleteBlock)(BOOL success);
typedef void(^OTSErrorHandleBlock)(OTSErrorHandleCompleteBlock errorHandleCompleteBlock);

@interface OTSNetworkError : NSObject

@property(nonatomic, copy) OTSErrorHandleBlock errorHandleBlock;//错误处理block
@property(nonatomic, assign) BOOL handling;//是否正在错误处理

/**
 *  功能:错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError;

@end
