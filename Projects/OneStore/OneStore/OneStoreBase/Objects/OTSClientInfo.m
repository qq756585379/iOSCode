//
//  OTSClientInfo.m
//  OneStoreFramework
//
//  Created by Aimy on 14-6-23.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSClientInfo.h"
//category
#import "NSObject+JsonToVO.h"
#import "UIDevice+IdentifierAddition.h"
//cache
#import "OTSKeychain.h"
#import "OTSUserDefault.h"
//model
#import <sys/utsname.h>
//idfa
#import <AdSupport/AdSupport.h>
#import "OTSGlobalValue.h"

#ifndef PHONE_TRACK_TYPE
#define PHONE_TRACK_TYPE 0
#endif

#if (PHONE_TRACK_TYPE == 0)
#define phoneTrackid @"8366231"
#define phoneTrackName @"appstore_iphone"
#define phoneCobubAppKey  @"93678a96a1be5c589cc8beb9a24f69bd"

#elif (PHONE_TRACK_TYPE == 1)
#define phoneTrackid @"9495060"
#define phoneTrackName @"同步助手_iphone"
#define phoneCobubAppKey @"0194ffe256ed43431fff61f9564c0104"

#elif (PHONE_TRACK_TYPE == 2)
#define phoneTrackid @"10107021978"
#define phoneTrackName @"91助手_iphone"
#define phoneCobubAppKey @"5c1e4ed208d2238fefe71450b3b28b22"

#elif (PHONE_TRACK_TYPE == 3)
#define phoneTrackid @"10875922787"
#define phoneTrackName @"PP助手_iphone"
#define phoneCobubAppKey @"12d3ca1efa5e4655d1f1ab7c2f408b3d"

#elif (PHONE_TRACK_TYPE == 4)
#define phoneTrackid @"10958540151"
#define phoneTrackName @"快用_iphone"
#define phoneCobubAppKey @"4d8e9aebb9a082370530961a08329c54"

#elif (PHONE_TRACK_TYPE==5)
#define phoneTrackid @"1063359230"
#define phoneTrackName @"91应用大赏_iphone"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efa"

#elif (PHONE_TRACK_TYPE==6)
#define phoneTrackid @"10342259732"
#define phoneTrackName @"苹果树助手_iphone"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==7)
#define phoneTrackid @"10599979166"
#define phoneTrackName @"爱思助手_iphone"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==8)
#define phoneTrackid @"10624889577"
#define phoneTrackName @"海马_iphone"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==9)
#define phoneTrackid @"106741185582"
#define phoneTrackName @"itools"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==10)
#define phoneTrackid @"106053185586"
#define phoneTrackName @"xy手机助手"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==11)
#define phoneTrackid @"103942187207"
#define phoneTrackName @"壹传-高铁管家"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==12)
#define phoneTrackid @"108830242488"
#define phoneTrackName @"i苹果助手_iphone"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==13)
#define phoneTrackid @"101207275551"
#define phoneTrackName @"神马SEM无线品牌"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==14)
#define phoneTrackid @"101972275553"
#define phoneTrackName @"神马SEM无线竞品"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==15)
#define phoneTrackid @"107226275555"
#define phoneTrackName @"神马SEM无线产品"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==16)
#define phoneTrackid @"105446275556"
#define phoneTrackName @"神马SEM无线活动"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==17)
#define phoneTrackid @"106138275509"
#define phoneTrackName @"百度SEM无线账户5"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==18)
#define phoneTrackid @"102128275513"
#define phoneTrackName @"百度SEM无线账户4"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==19)
#define phoneTrackid @"108119275515"
#define phoneTrackName @"百度SEM无线账户2"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==20)
#define phoneTrackid @"105661275519"
#define phoneTrackName @"百度SEM无线账户1"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==21)
#define phoneTrackid @"106822275523"
#define phoneTrackName @"百度SEM虚拟账户"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==22)
#define phoneTrackid @"101117275565"
#define phoneTrackName @"360SEM无线品牌"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==23)
#define phoneTrackid @"107223275566"
#define phoneTrackName @"360SEM无线竞品"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==24)
#define phoneTrackid @"105472275568"
#define phoneTrackName @"360SEM无线产品"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==25)
#define phoneTrackid @"107727275570"
#define phoneTrackName @"360SEM无线活动"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==26)
#define phoneTrackid @"103742275572"
#define phoneTrackName @"必应SEM无线端_1"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==27)
#define phoneTrackid @"108785743279"
#define phoneTrackName @"百度无线DSP-目标人群-积分墙_1_IOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==28)
#define phoneTrackid @"105498743279"
#define phoneTrackName @"百度无线DSP-目标人群-积分墙_2_IOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==29)
#define phoneTrackid @"101159743279"
#define phoneTrackName @"百度无线DSP-目标人群-积分墙_3_IOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==30)
#define phoneTrackid @"106001743279"
#define phoneTrackName @"百度无线DSP-目标人群-积分墙_4_IOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==31)
#define phoneTrackid @"102622743279"
#define phoneTrackName @"百度无线DSP-目标人群-积分墙_5_IOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#elif (PHONE_TRACK_TYPE==32)
#define phoneTrackid @"1070912531021"
#define phoneTrackName @"360DSP_iOS"
#define phoneCobubAppKey @"47898c05b71a5d8cb2cdc0244b931efb"

#endif


#ifndef PAD_TRACK_TYPE
#define PAD_TRACK_TYPE 0
#endif

#if (PAD_TRACK_TYPE == 0)
#define padTrackid @"10442025702"
#define padTrackName @"appstore_ipad"

#elif (PAD_TRACK_TYPE == 1)
#define padTrackid @"10179025705"
#define padTrackName @"同步助手_ipad"

#elif (PAD_TRACK_TYPE == 2)
#define padTrackid @"10833825707"
#define padTrackName @"91助手_ipad"

#elif (PAD_TRACK_TYPE == 3)
#define padTrackid @"10846625708"
#define padTrackName @"PP助手_ipad"

#elif (PAD_TRACK_TYPE == 4)
#define padTrackid @"10111840233"
#define padTrackName @"快用_ipad"
#endif

@interface OTSClientInfo ()


@end

@implementation OTSClientInfo
DEF_SINGLETON(OTSClientInfo)

- (id)init {
    self = [super init];
    if (self) {
        _clientAppVersion = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _clientVersion = [[UIDevice currentDevice] systemVersion];
        _deviceCode = [NSString stringWithString:[[UIDevice currentDevice] uniqueDeviceIdentifier]];
        _unionKey = phoneTrackid;
        _iaddr = @1;
        _nettype = @"";

        if (IS_IPHONE_DEVICE) {
            _unionKey = phoneTrackid;
            _clientSystem = @"iPhone";
            _traderName = @"iosSystem";
            NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
            if ([bundleIdentifier rangeOfString:@"sam"].location != NSNotFound) {
                _traderName = @"samIosSystem";
            }
            
        }else {
            _unionKey = padTrackid;
            _clientSystem = @"ipad";
            _traderName = @"ipadSystem";
        }
}
    
    return self;
}

- (NSString *)deviceToken
{
    if ([OTSGlobalValue sharedInstance].deviceToken!=nil) {
        return [OTSGlobalValue sharedInstance].deviceToken;
    }
    return _deviceToken;
}

- (NSString *)idfa{
    if ([ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString!=nil) {
        return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
    }
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
    return [OTSKeychain getKeychainValueForType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE_CHANNEL_ID];
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
    [OTSKeychain setKeychainValue:pointWallChannelId forType:OTS_DEF_KEY_IS_DO_POINTWALL_ACTIVE_CHANNEL_ID];
}

- (NSNumber *)abtest
{
    return [OTSUserDefault getValueForKey:OTS_DEF_KEY_ABTEST];
}

- (void)setAbtest:(NSNumber *)abtest
{
    [OTSUserDefault setValue:abtest forKey:OTS_DEF_KEY_ABTEST];
}

- (NSString*) phoneType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{
                              
                              @"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              
                              @"iPod1,1"   :@"iPod Touch ",        // (Original)
                              @"iPod2,1"   :@"iPod Touch 2G",        // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch 3G",        // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch 4G",        // (Fourth Generation)
                              @"iPod5,1"    :@"iPod Touch 5G",
                              @"iPod7,1"   :@"iPod Touch  6G",        // (6th Generation)
                              
                              @"iPhone1,1" :@"iPhone",            // (Original)
                              @"iPhone1,2" :@"iPhone3G",            // (3G)
                              @"iPhone2,1" :@"iPhone3GS",            // (3GS)
                              @"iPhone3,1" :@"iPhone 4",          // (GSM)
                              @"iPhone3,2" :@"iPhone 4",          // (GSM)
                              @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",         //
                              @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                              @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",     //
                              @"iPhone7,2" :@"iPhone 6",          //
                              @"iPhone8,1" :@"iPhone 6S",         //
                              @"iPhone8,2" :@"iPhone 6S Plus",    //
                              @"iPhone8,4" :@"iPhone SE",         //
                              
                              @"iPad1,1"   :@"iPad",              // (Original)
                              @"iPad2,1"   :@"iPad 2",            //（A1395）
                              @"iPad2,2"   :@"iPad 2",            // （A1396）
                              @"iPad2,3"   :@"iPad 2",            // （A1397）
                              @"iPad2,4"   :@"iPad 2",            // （A1395）
                              @"iPad3,1"   :@"iPad 3",              // (3rd Generation)A1416
                              @"iPad3,2"   :@"iPad 3",              // (3rd Generation)A1403
                              @"iPad3,3"   :@"iPad 3",              // (3rd Generation)A1430
                              @"iPad3,4"   :@"iPad 4",              // (4th Generation)A1458
                              @"iPad3,5"   :@"iPad 4",              // (4th Generation)A1459
                              @"iPad3,6"   :@"iPad 4",              // (4th Generation)A1460
                              @"iPad4,1"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,3"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad5,3"   :@"iPad Air2",          // 5th Generation iPad (iPad Air2) - WifiA1566
                              @"iPad5,4"   :@"iPad Air2",          // 5th Generation iPad (iPad Air2) - CellularA1567
                              @"iPad2,5"   :@"iPad Mini",         // (Original)  A1432
                              @"iPad2,6"   :@"iPad Mini",         // (Original)  A1454
                              @"iPad2,7"   :@"iPad Mini",         // (Original)  A1455
                              @"iPad4,4"   :@"iPad Mini 2",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini 2",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,6"   :@"iPad Mini 2",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad4,7"   :@"iPad Mini 3",         //
                              @"iPad4,8"   :@"iPad Mini 3",         //
                              @"iPad4,9"   :@"iPad Mini 3",         //
                              @"iPad5,1"   :@"iPad Mini 4",         //
                              @"iPad5,2"   :@"iPad Mini 4",         //
                              @"iPad6,7"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   :@"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   :@"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              
                              };
    }
    
    NSString* phoneType = [deviceNamesByCode objectForKey:code];
    
    if (phoneType.length <= 0) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            phoneType = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            phoneType = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            phoneType = @"iPhone";
        }
        else {
            phoneType = @"Unknown";
        }
    }
    
    return phoneType;
}


@end
