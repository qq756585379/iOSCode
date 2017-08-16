//
//  OTSConnectUrl.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSConnectUrl.h"

NSString * const  OTSProductConnectUrlAddress = @"http://mapi.yhd.com";//OneStore Product环境
NSString * const  OTSTestConnectUrlAddress = @"http://10.161.144.89:9090";//OneStore Test环境
NSString * const  OTSStgConnectUrlAddress = @"http://103.243.252.118";//OneStore STG环境
#pragma mark - Key
NSString * const OTSCurrentEnvironmentTypeKey = @"OTSCurrentEnvironmentTypeKey";
NSString * const OTSEnvironmentTypeProductKey = @"OTSEnvironmentTypeProductKey";
NSString * const OTSEnvironmentTypeTestKey = @"OTSEnvironmentTypeTestKey";
NSString * const OTSEnvironmentTypeStgKey = @"OTSEnvironmentTypeStgKey";

@implementation OTSConnectUrl

@synthesize networkEnvironmentType = _networkEnvironmentType;

DEF_SINGLETON(OTSConnectUrl)

/**
 *  设置所有环境的地址
 */
- (void)setupAllEnvironmentAddress{
    [OTSUserDefault setValue:OTSProductConnectUrlAddress forKey:(NSString *)OTSEnvironmentTypeProductKey];
#if DEBUG
    [OTSUserDefault setValue:OTSTestConnectUrlAddress forKey:(NSString *)OTSEnvironmentTypeTestKey];
    [OTSUserDefault setValue:OTSStgConnectUrlAddress  forKey:(NSString *)OTSEnvironmentTypeStgKey];
#endif
}

- (NSString *)getConnectUrlAddressWithType:(OTSNetworkEnvironmentType )type{
    NSString *connectUrlAddress = OTSProductConnectUrlAddress;
    switch (type) {
        case OTSNetworkEnvironmentTypeProduct:
            connectUrlAddress = [OTSUserDefault getValueForKey:(NSString*)OTSEnvironmentTypeProductKey];
            break;
        case OTSNetworkEnvironmentTypeTest:
            connectUrlAddress = [OTSUserDefault getValueForKey:(NSString *)OTSEnvironmentTypeTestKey];
            break;
        case OTSNetworkEnvironmentTypeStg:
            connectUrlAddress = [OTSUserDefault getValueForKey:(NSString *)OTSEnvironmentTypeStgKey];
            break;
        default:
            connectUrlAddress = OTSProductConnectUrlAddress;
            break;
    }
    return connectUrlAddress;
}

- (NSString *)getCurrentContentUrlAddress{
    NSString*currentAddress =  [self getConnectUrlAddressWithType:self.networkEnvironmentType];
    if (currentAddress.length <= 0) {
        currentAddress = OTSProductConnectUrlAddress;
    }
    return currentAddress;
}

#pragma mark- setter&getter
- (void)setNetworkEnvironmentType:(OTSNetworkEnvironmentType)environmentType{
    if (self.networkEnvironmentType != environmentType) {
        _networkEnvironmentType = environmentType;
        [OTSUserDefault setValue:@(_networkEnvironmentType) forKey:(NSString*)OTSCurrentEnvironmentTypeKey];
    }
}

- (OTSNetworkEnvironmentType )networkEnvironmentType{
    NSNumber *typeNum =  [OTSUserDefault getValueForKey:(NSString *)OTSCurrentEnvironmentTypeKey];
    if (!typeNum) {
        typeNum = @0;
    }
    return typeNum.integerValue;
}

@end
