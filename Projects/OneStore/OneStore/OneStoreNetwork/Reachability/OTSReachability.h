//
//  OTSReachability.h
//  OneStoreFramework
//
//  Created by qinqubo on 14/10/4.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ENetWorkStatus) {
    kConnectToNull = 0,
    kConnectTo2G   = 1 << 0,
    kConnectTo3G   = 1 << 1,
    kConnectTo4G   = 1 << 2,
    kConnectToWWAN = 1 << 3,
    kConnectToWifi = 1 << 4,
    /**
     *  联网了
     */
    kConnectToAny  = (kConnectTo2G | kConnectTo3G | kConnectTo4G | kConnectToWWAN | kConnectToWifi)
};

/**
 *  网络不可用回调
 */
typedef void(^UnReachableBlock)(void);

@interface OTSReachability : NSObject

AS_SINGLETON(OTSReachability);

@property (nonatomic, assign) ENetWorkStatus currentNetStatus;

@property (nonatomic, assign) NSString *currentNetStatusForTracker;
/**
 *  是否联网了
 */
@property (nonatomic, getter=isConnectedToNet, readonly) BOOL connectedToNet;

/**
 *  功能:获取网络连接状况
 */
- (void)generateNetStatus;

@end







