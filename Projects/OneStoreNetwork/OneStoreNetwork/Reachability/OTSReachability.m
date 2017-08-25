//
//  OTSReachability.m
//  OneStoreFramework
//
//  Created by qinqubo on 14/10/4.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSReachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//global
#import "OTSClientInfo.h"
//category
#import "NSObject+BeeNotification.h"
#import "OTSNotificationDefine.h"

/**
 *  网络状态更新
 */
NSString *const NotificationNetworkStatusChange = @"NotificationNetworkStatusChange";
/**
 *  有网络
 */
NSString *const NotificationNetworkStatusReachable = @"NotificationNetworkStatusReachable";

@interface OTSReachability()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@property (nonatomic, assign) ENetWorkStatus lastNetStatus;
@end

@implementation OTSReachability

DEF_SINGLETON(OTSReachability)

- (instancetype)init{
    if (self = [super init]) {
        WEAK_SELF;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            [NSNotificationCenter.defaultCenter addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                                            object:nil
                                                             queue:[NSOperationQueue mainQueue]
                                                        usingBlock:^(NSNotification *note){
                                                            STRONG_SELF;
                                                            NSString *status = note.object;
                                                            [self dealWithCT:status];
                                                        }];
        }
        
        [NSNotificationCenter.defaultCenter addObserverForName:AFNetworkingReachabilityDidChangeNotification
                                                        object:nil
                                                         queue:[NSOperationQueue mainQueue]
                                                    usingBlock:^(NSNotification *note){
                                                        STRONG_SELF;
                                                        NSNumber *item = note.userInfo[AFNetworkingReachabilityNotificationStatusItem];
                                                        AFNetworkReachabilityStatus status = (AFNetworkReachabilityStatus)item.intValue;
                                                        [self dealWithReachabilityStatus:status];
                                                    }];
        
        _manager = [AFNetworkReachabilityManager sharedManager];
        [_manager startMonitoring];
    }
    return self;
}

- (void)setCurrentNetStatus:(ENetWorkStatus)currentNetStatus{
    if (_currentNetStatus != currentNetStatus) {
        _currentNetStatus = currentNetStatus;
        //网络类型
        switch (currentNetStatus) {
            case kConnectTo2G:
                [OTSClientInfo sharedInstance].nettype = @"2g";
                break;
            case kConnectTo3G:
                [OTSClientInfo sharedInstance].nettype = @"3g";
                break;
            case kConnectTo4G:
                [OTSClientInfo sharedInstance].nettype = @"4g";
                break;
            case kConnectToWifi:
                [OTSClientInfo sharedInstance].nettype = @"wifi";
                break;
            case kConnectToWWAN:
                //do nothing
                break;
            default:
                [OTSClientInfo sharedInstance].nettype = @"";
                break;
        }
    }
}

- (void)dealloc{
    [self.manager stopMonitoring];
    [self unobserveAllNotifications];
}

- (void)generateNetStatus{
    //new telephonyInfo will post a notification CTRadioAccessTechnologyDidChangeNotification
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
        [self dealWithCT:telephonyInfo.currentRadioAccessTechnology];
    }
}

- (void)dealWithCT:(NSString *)status{
    NSLog(@"New Radio Access Technology: %@", status);
    //2g,2.5g
    if ([status isEqualToString:CTRadioAccessTechnologyGPRS] ||
        [status isEqualToString:CTRadioAccessTechnologyEdge]) {
        self.currentNetStatus = kConnectTo2G;
        self.currentNetStatusForTracker = @"2g";
    }
    //3g
    else if ([status isEqualToString:CTRadioAccessTechnologyWCDMA] ||
             [status isEqualToString:CTRadioAccessTechnologyHSDPA] ||
             [status isEqualToString:CTRadioAccessTechnologyHSUPA] ||
             [status isEqualToString:CTRadioAccessTechnologyCDMA1x] ||
             [status isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
             [status isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
             [status isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
             [status isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        self.currentNetStatus = kConnectTo3G;
        self.currentNetStatusForTracker = @"3g";
    }
    //4g
    else if ([status isEqualToString:CTRadioAccessTechnologyLTE]){
        self.currentNetStatus = kConnectTo4G;
        self.currentNetStatusForTracker = @"4g";
    }
    else {
        self.currentNetStatus = kConnectToNull;
        self.currentNetStatusForTracker = @"无网";
    }
    [self dealWithReachabilityStatus:self.manager.networkReachabilityStatus];
}

- (void)dealWithReachabilityStatus:(AFNetworkReachabilityStatus)status{
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"NotReachable notify recieved!");
            self.currentNetStatus = kConnectToNull;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"ReachableViaWWAN notify recieved!");
            self.currentNetStatus = kConnectToWWAN;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"ReachableViaWiFi notify recieved!");
            self.currentNetStatus = kConnectToWifi;
            break;
        default:
            break;
    }
    if (self.lastNetStatus != self.currentNetStatus || self.currentNetStatus == kConnectToNull) {
        [self postNotification:OTS_HOMEPAGE_SHOW_NOWORK];//首页无网络提示
    }
    if (self.lastNetStatus != self.currentNetStatus) {
        self.lastNetStatus = self.currentNetStatus;
        [self postNotification:NotificationNetworkStatusChange];
    }
}

- (BOOL)isConnectedToNet{
    return (self.currentNetStatus & kConnectToAny);
}

@end
