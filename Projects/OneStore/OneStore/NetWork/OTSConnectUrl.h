//
//  OTSConnectUrl.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,OTSNetworkEnvironmentType){
    OTSNetworkEnvironmentTypeProduct = 0, //生成环境,线上环境
    OTSNetworkEnvironmentTypeTest = 1, //测试环境
    OTSNetworkEnvironmentTypeStg = 2, //stg环境
};

UIKIT_EXTERN NSString * const OTSEnvironmentTypeProductKey;
UIKIT_EXTERN NSString * const OTSEnvironmentTypeTestKey;
UIKIT_EXTERN NSString * const OTSEnvironmentTypeStgKey;

@interface OTSConnectUrl : NSObject

AS_SINGLETON(OTSConnectUrl)

@property (nonatomic, assign) OTSNetworkEnvironmentType networkEnvironmentType;

/**
 *  设置所有环境的请求地址.
 *  子类重载此方法，来设置不同环境的地址
 */
- (void)setupAllEnvironmentAddress;

/**
 *  获取当前app的网络请求地址
 */
- (NSString *)getCurrentContentUrlAddress;

/**
 *  根据环境来获取请求地址
 *  获取线上环境、测试环境、stg环境的请求地址
 */
- (NSString *)getConnectUrlAddressWithType:(OTSNetworkEnvironmentType )type;

@end
