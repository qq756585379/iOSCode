//
//  OTSClientInfo.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

@interface OTSClientInfo : NSObject

HMSingletonH

@property (nonatomic, copy) NSString *clientAppVersion;// 客户端app版本号
@property (nonatomic, copy) NSString *clientSystem;// 客户端系统
@property (nonatomic, copy) NSString *clientVersion;// 客户端版本
@property (nonatomic, copy) NSString *deviceToken;//推送的Devicetoken
@property (nonatomic, copy) NSString *idfa;
@property (nonatomic, copy) NSString *deviceCode;// 设备号
@property (nonatomic, copy) NSString *phoneType;// 设备号  ----4.2.4新增
@property (nonatomic, copy) NSString *traderName;// 平台名称
@property (nonatomic, copy) NSString *unionKey;// 渠道id
@property (nonatomic, copy) NSString *nettype;// 网络类型
@property (nonatomic, copy) NSNumber *iaddr;

@property (nonatomic, copy) NSNumber *latitude;// 纬度
@property (nonatomic, copy) NSNumber *longitude;// 经度

@property (nonatomic, copy) NSNumber *pointWallChannelId;//下载渠道ID

@property (nonatomic, copy) NSNumber *abtest;//abtest值

// 打开渠道的字段添加
@property (nonatomic, copy) NSString *tracker_u;// 打开渠道
@property (nonatomic, copy) NSString *website_id;// 网址
@property (nonatomic, copy) NSString *uid;// 用户id

@end
