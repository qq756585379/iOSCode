//
//  OTSBIGlobalValue.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

@interface OTSBIGlobalValue : NSObject

HMSingletonH

@property (nonatomic, strong) NSString *locationInfo;       // 经纬度定位地址
@property (nonatomic, strong) NSString *proviceInfo;        // 省份地址
@property (nonatomic, strong) NSString *proviceID;          // 省份ID
@property (nonatomic, strong) NSString *cityInfo;           // 城市地址
@property (nonatomic, strong) NSString *cityID;             // 城市ID
@property (nonatomic, strong) NSString *trackerUrl;         // w_bu 打开渠道
@property (nonatomic, strong) NSString *keywordId;          // w_ak 关键字
@property (nonatomic, strong) NSString *websiteAndUid;      // w_ck Websiteid和uid
@property (nonatomic, strong) NSString *website;            // Websiteid（为了h5的cookie）
@property (nonatomic, strong) NSString *uid;                // uid（为了h5的cookie）
@property (nonatomic, assign) CGFloat u_lon;                // 经度
@property (nonatomic, assign) CGFloat u_lat;                // 纬度
@property (nonatomic, strong) NSString *client_time;        // 客户端时间


// 获取合适的 sessionId
- (NSString *)generateSessionId;

@end
