//
//  OTSClientInfo.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSClientInfo.h"
#import "CommonDefine.h"

@implementation OTSClientInfo

HMSingletonM

- (id)init {
    self = [super init];
    if (self) {
        _clientAppVersion = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _clientVersion = [[UIDevice currentDevice] systemVersion];
        _iaddr = @1;
        _nettype = @"";
    
        if (IS_IPHONE_DEVICE) {
            _clientSystem = @"iPhone";
            _traderName = @"iosSystem";
            NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
            if ([bundleIdentifier rangeOfString:@"sam"].location != NSNotFound) {
                _traderName = @"samIosSystem";
            }
        }else {
            _clientSystem = @"ipad";
            _traderName = @"ipadSystem";
        }
    }
    return self;
}

- (NSString *)deviceToken
{
//    if ([OTSGlobalValue sharedInstance].deviceToken!=nil) {
//        return [OTSGlobalValue sharedInstance].deviceToken;
//    }
    return _deviceToken;
}

- (NSString *)idfa{
//    if ([ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString!=nil) {
//        return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
//    }
    return _idfa;
}

- (void)setLongitude:(NSNumber *)longitude
{
    _longitude = longitude;
}

- (void)setLatitude:(NSNumber *)latitude
{
    _latitude = latitude;
}

- (NSNumber *)pointWallChannelId
{
    return @0;
//    return [OTSKeychain getKeychainValueForType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE_CHANNEL_ID];
}

- (NSString *)unionKey
{
    if (self.pointWallChannelId.integerValue > 0) {
        return self.pointWallChannelId.stringValue;
    }
    return _unionKey;
}

-(void)setPointWallChannelId:(NSNumber *)pointWallChannelId
{
//    [OTSKeychain setKeychainValue:pointWallChannelId forType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE_CHANNEL_ID];
}

//- (NSNumber *)abtest
//{
//    return [OTSUserDefault getValueForKey:OTS_DEF_KEY_ABTEST];
//}

//- (void)setAbtest:(NSNumber *)abtest
//{
//    [OTSUserDefault setValue:abtest forKey:OTS_DEF_KEY_ABTEST];
//}


@end
