//
//  OTSOperationManager.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "OTSOperationParam.h"

typedef NS_ENUM(NSInteger, ForceTip){
    kShowAWhile = 0,             //显示一会提示
    kForceShow,                  //强制显示
    kForceJump,                  //强行跳转
    KForceUpdate                 //强制更新模块
};

@interface OTSOperationManager : AFHTTPSessionManager

@property(nonatomic, strong) NSString *hostClassName;//宿主名称

+ (instancetype)manager;

+ (instancetype)managerWithOwner:(id)owner;
/**
 *  功能:发送请求
 */
- (NSURLSessionDataTask *)requestWithParam:(OTSOperationParam *)aParam;
/**
 *  发送网络请求，创建信号
 */
- (RACSignal *)rac_requestWithParam:(OTSOperationParam *)aParam;
/**
 *  功能:取消当前manager queue中所有网络请求
 */
- (void)cancelAllOperations;
/**
 *  功能:launch接口调用失败时将operation暂存
 */
- (void)cacheOperationForLaunchFail:(OTSOperationParam *)aParam;

@end












