//
//  OTSGlobalValue.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

typedef NS_ENUM(NSInteger ,OTSRegionType){
    OTSRegionTypeNormal  = 0,
    OTSRegionTypeApollo  = 1,
    OTSRegionTypeWalmart = 2,
};

@interface OTSGlobalValue : NSObject

AS_SINGLETON(OTSGlobalValue)

@property (nonatomic, assign) NSTimeInterval dTime;//服务器时间-客户端时间
@property (nonatomic, copy) NSDate         *serverTime;//根据差值算出的服务器时间
@property (nonatomic, copy) NSString       *token;//token
@property (nonatomic, copy) NSNumber       *userId;//用户id
@property (nonatomic, copy) NSNumber       *locatedCityId;  //定位出的城市id
@property (nonatomic, copy) NSString       *sessionId;//sessionid，相当于cookie的id
@property (nonatomic, copy) NSNumber       *cartCount;//购物车数量
@property (nonatomic, copy) NSNumber       *messageCount;//未读消息数量
@property (nonatomic, copy) NSNumber       *chatMessageCount; // 不包括系统消息的未读聊天数量
@property (nonatomic, copy) NSString       *deviceToken;//推送的Devicetoken

@property (nonatomic, getter = isBindModile) BOOL bindModile;//是否绑定了手机
@property (nonatomic, getter = isFirstLaunch) BOOL firstLaunch;//是否是当前版本包得第一次启动
@property (nonatomic, getter = isActiveLaunch) BOOL activeLaunch;//是否是第一次安装后启动
@property (nonatomic, getter = isSignToday) BOOL signToday; // 今天是否已经签到

@property (nonatomic, getter = isDoPointWallActive) BOOL doPointWallActive;//是否激活过积分墙

@property (nonatomic, copy) NSString *boundPhoneNum;//当前用户已绑定的手机号码

@property (nonatomic) OTSRegionType regionType;//位置type
//在线客服
@property (nonatomic, copy) NSString *cid;              // 客服中心客户端标识
@property (nonatomic, copy) NSString *sid;              // 客服中心会话标识
@property (nonatomic, copy) NSString *sut;              // 客服中心必传字段
@property (nonatomic, copy) NSNumber *customerId;       // 客服中心用户id
@property (nonatomic, copy) NSString *recConfTicket;    // 长轮询标识
@property (nonatomic, copy) NSNumber *sellerType;       // dsv标示
@property (nonatomic, copy) NSNumber *supplierId;       // dsv商家ID

@property (nonatomic) BOOL latestVersion;//是否是最新版本
@property (nonatomic) BOOL haveCreatedMessage;//是否已创建更新有奖消息

@property(nonatomic, assign) int hasBabyInfo;                     //是否填写过宝宝资料 0未填 1已填 2未知
//ipad在线客服
@property (nonatomic, strong) NSMutableDictionary *customerInfos;//历史客服信息
@property (nonatomic, strong) NSMutableDictionary *messagerSessionInfos;//历史客服信息
//爱分享
@property (nonatomic, copy) NSString *userPicUrl;        //当前用户头像url
@property (nonatomic, copy) NSString *userNickName;      //当前用户昵称

@property (nonatomic, assign) BOOL showMarketPrice; // 是否显示市场价（划去价）
//webp
@property (nonatomic, copy) NSNumber *useWebp;           //是否使用webp图片
//AR开关
@property (nonatomic, copy) NSNumber *aradvert;
//For pad

@property(nonatomic, assign) BOOL showCategoryPic;//类目是否显示图片

//结算页公告开关
@property(nonatomic, assign) BOOL billBoardSwitch;//公告开关
@property(nonatomic, copy) NSString *billBoardStr; //公告文描

@property(nonatomic, assign) BOOL hideYearCheck;//是否隐藏年度账单

@property(nonatomic, assign) BOOL firstShowSwitchProvince;//是否是当前版本包第一次打开切换省份界面

@property (nonatomic, strong) NSNumber *redRainH5Control; // H5 红包雨控制本地红包雨是否在 CMS 页面展示，1:本地不展示 0:本地展示
@property(nonatomic, assign) BOOL grouponHomeOlockRefreshed;//团购首页金牌秒杀刷新;

@property (nonatomic, assign)BOOL firstEntry;//视频播放判断用户是否wifi状态

@property (nonatomic, copy) NSString *signatureKey;//解密后的签名密钥

@end
