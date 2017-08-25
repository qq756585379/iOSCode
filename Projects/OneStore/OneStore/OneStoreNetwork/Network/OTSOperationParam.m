//
//  OTSOperationParam.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSOperationParam.h"
#import "OTSConnectUrl.h"

@implementation OTSOperationParam

- (instancetype)init{
    self = [super init];
    if (self) {
        self.needSignature = YES;
        self.needEncoderToken = YES;
        self.retryTimes = 1;
        self.cacheTime = 0;
        self.timeoutTime = 10;
        
        self.rerunForTokenExpire = NO;
        self.rerunForLaunchFail = NO;
        self.alertError = NO;
        self.showErrorView = NO;
    }
    return self;
}

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithBusinessName:(NSString *)aBusinessName
                           methodName:(NSString *)aMethodName
                           versionNum:(NSString *)aVersionNum
                                 type:(ERequestType)aType
                                param:(NSDictionary *)aParam
                             callback:(OTSCompletionBlock)aCallback{
    OTSOperationParam *param = [self new];
    param.businessName = aBusinessName;
    param.methodName = aMethodName;
    param.versionNum = aVersionNum;
    NSString *domain = param.currentDomain;
    if (aVersionNum.length > 0) {
        param.requestUrl = [NSString stringWithFormat:@"%@/%@/%@/%@", domain, aBusinessName, aMethodName, aVersionNum];
    } else {
        param.requestUrl = [NSString stringWithFormat:@"%@/%@/%@", domain, aBusinessName, aMethodName];
    }
    param.requestType = aType;
    param.requestParam = aParam ? aParam : [NSMutableDictionary dictionary];
    param.callbackBlock = aCallback;
    return param;
}

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                        type:(ERequestType)aType
                       param:(NSDictionary *)aParam
                    callback:(OTSCompletionBlock)aCallback{
    OTSOperationParam *param = [self new];
    param.requestUrl = aUrl;
    param.requestType = aType;
    param.requestParam = aParam ? aParam : [NSMutableDictionary dictionary];
    param.callbackBlock = aCallback;
    
    //for print log
    param.methodName = aUrl;
    
    return param;
}

/**
 *  功能:当前域名
 */
- (NSString *)currentDomain{
    return  [[OTSConnectUrl sharedInstance] getCurrentContentUrlAddress];
}

@end
