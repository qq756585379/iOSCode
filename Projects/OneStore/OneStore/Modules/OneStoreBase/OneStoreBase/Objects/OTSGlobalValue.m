//
//  OTSGlobalValue.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSGlobalValue.h"
#import "OTSUserDefaultDefine.h"
#import "OTSUserDefault.h"

NSString *const KeyChainSignatureKey = @"keychain.signatureKey";

@interface OTSGlobalValue()
@property (nonatomic, copy) NSString *signatureKey;                  //解密后的签名密钥
@end

@implementation OTSGlobalValue

DEF_SINGLETON(OTSGlobalValue)

- (instancetype)init{
    if (self = [super init]) {
        
//        NSNumber *isActive = [OTSKeychain getKeychainValueForType:OTS_KEYCHAIN_ISACTIVE];
//        if (!isActive.boolValue) {
//            self.activeLaunch = YES;
//            [OTSKeychain setKeychainValue:@(YES) forType:OTS_KEYCHAIN_ISACTIVE];
//        }
        
        //是否新版本第一次启动
        NSString *lastRunVersion = [OTSUserDefault getValueForKey:OTS_DEF_KEY_LAST_RUN_VERSION];
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        if (!lastRunVersion || ![lastRunVersion isEqualToString:currentVersion]) {
            self.firstLaunch = YES;
            [OTSUserDefault setValue:currentVersion forKey:OTS_DEF_KEY_LAST_RUN_VERSION];
        } else {
            self.firstLaunch = NO;
        }
        //是否已创建消息
        NSNumber *haveCreatedMessage = [OTSUserDefault getValueForKey:OTS_DEF_KEY_HAVE_CREATED_MESSAGE];
        self.haveCreatedMessage = haveCreatedMessage.boolValue;
        if (self.firstLaunch) {
            self.haveCreatedMessage = NO;
            [OTSUserDefault setValue:@(NO) forKey:OTS_DEF_KEY_HAVE_CREATED_MESSAGE];
        }
        //获取session id，用于购物车接口端本地缓存
        self.sessionId = [OTSUserDefault getValueForKey:OTS_DEF_KEY_SESSION_ID];
        
        self.customerInfos = @{}.mutableCopy;
        self.messagerSessionInfos = @{}.mutableCopy;
    }
    return self;
}

//- (NSString *)signatureKey{
//    if (_signatureKey == nil) {
//        _signatureKey = [OTSKeychain getKeychainValueForType:KeyChainSignatureKey];
//    }
//    return _signatureKey;
//}

//- (void)setSignatureKey:(NSString *)signatureKey{
//    _signatureKey = [signatureKey copy];
//    [OTSKeychain setKeychainValue:signatureKey forType:KeyChainSignatureKey];
//}

//- (NSNumber *)locatedCityId{
//    if (_locatedCityId == nil) {
//        _locatedCityId = [OTSUserDefault getValueForKey:@"OTS_DEF_KEY_LOCATED_CITYID"];
//    }
//    return _locatedCityId;
//}

//- (void)setLocatedCityId:(NSNumber *)locatedCityId{
//    if ([locatedCityId safeIsEqualToNumber:_locatedCityId]) {
//        return;
//    }
//    _locatedCityId = @(locatedCityId.integerValue);
//    [OTSUserDefault setValue:locatedCityId forKey:@"OTS_DEF_KEY_LOCATED_CITYID"];
//    
//}
- (NSDate *)serverTime{
    //根据本地时间与服务器时间的差异 算出的当前服务器的时间  **不要乱改，其他地方有用到
    _serverTime = [NSDate dateWithTimeIntervalSinceNow:self.dTime];
    return _serverTime;
}

//- (NSString*)deviceToken{
//    if (_deviceToken==nil) {
//        _deviceToken=[OTSKeychain getKeychainValueForType:OTS_KEYCHAIN_DEVICETOKEN];
//    }
//    return _deviceToken;
//}
/**
 *  功能:方法重写，保证返回不为nil
 */
//- (NSString *)sessionId{
//    if (_sessionId == nil) {
//        return @"";
//    } else {
//        return _sessionId;
//    }
//}

- (void)setRegionType:(OTSRegionType)regionType{
    [[NSUserDefaults standardUserDefaults] setInteger:regionType forKey:OTS_DEF_KEY_REGION_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (OTSRegionType)regionType{
    return (OTSRegionType)[[NSUserDefaults standardUserDefaults] integerForKey:OTS_DEF_KEY_REGION_TYPE];
}


//- (BOOL)isDoPointWallActive{
//    NSNumber *pointWallActive = [OTSKeychain getKeychainValueForType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE];
//    
//    if (pointWallActive == nil) {
//        return NO;
//    }
//    return pointWallActive.boolValue;
//}


//- (void)setDoPointWallActive:(BOOL)doPointWallActive{
//    [OTSKeychain setKeychainValue:@(YES) forType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE];
//}

//- (NSNumber *)userId{
//    _userId = [OTSUserDefault getValueForKey:@"userid"];
//    return _userId;
//}


//- (void)setUserId:(NSNumber *)userId{
//    if (userId == nil) {
//        _userId = nil;
//        [OTSUserDefault setValue:_userId forKey:@"userid"];
//    } else if (![_userId isKindOfClass:[NSNumber class]] || ![_userId isEqualToNumber:userId]) {
//        _userId = userId;
//        [OTSUserDefault setValue:_userId forKey:@"userid"];
//    }
//}

-(void)setSessionId:(NSString *)sessionId{
    if (![_sessionId isEqualToString:sessionId]) {
        _sessionId = sessionId;
        [OTSUserDefault setValue:_sessionId forKey:OTS_DEF_KEY_SESSION_ID];
    }
}

- (NSNumber *)redRainH5Control {
    if (!_redRainH5Control) {
        _redRainH5Control = @(0);
    }
    return _redRainH5Control;
}

@end
