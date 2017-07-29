//
//  OTSFunctionSwithLogic.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLogic.h"
@class AppFunctionSwitchVO;

@interface OTSFunctionSwithLogic : OTSLogic

AS_SINGLETON(OTSFunctionSwithLogic)

/**
 * type            typeName                   staus
 
 * CMS_CACHE       CMS详情页缓存开关
 
 * balance           余额
 
 * checkhasgift      赠品
 
 * coupon            抵用券
 
 * flashBag          闪购袋开关
 
 * inshop            店中店开关
 
 * interfaceversion  接口版本
 
 * marketprice       市场价开关
 
 * usepcbackend      pc广告开关
 
 * onlineService    在线客服开关
 
 * gameCard_iosSystem 点卡充值开关
 *
 */
@property(nonatomic, strong)NSMutableDictionary *functionSwitchDict; //开关字典.key为模块名称，value为模块的配置<AppFunctionSwitchVO>

- (void)getAppFunctionSwitch;

/**
 *	功能:余额的状态值
 */
- (BOOL)balanceState;

/**
 *	功能:抵用券开发值
 */
- (BOOL)couponState;

/**
 *	功能:店中店开发值
 */
- (BOOL)inshopState;

/**
 *	功能:赠品开关
 */
- (BOOL)checkhasgiftState;

/**
 *	功能:接口版本开关
 */
- (BOOL)interfaceversionState;

/**
 *	功能:市场价开关
 */
- (BOOL)marketpriceState;

/**
 *	功能:pc广告开关
 */
- (BOOL)userbackendState;

/**
 *	功能:CMS商品详情开关
 */
- (BOOL)CMS_CACHEState;

/**
 *	功能:闪购袋开关
 */
- (BOOL)flahBagState;

/**
 *	功能:在线客服开关
 */
- (BOOL)onlineServiceState;
/**
 *	功能:会员中心开关
 */
- (BOOL)showVIPCenter;

/**
 *	功能:积分商城开关
 */
- (BOOL)showIntegrationMall;

/**
 *	功能:点卡充值开关
 */
- (BOOL)showGameCard;

/**
 *	功能:点卡充值URL
 */
- (NSString *)gameCardURL;

/**
 *	功能:充值中心 游戏开关
 */
- (BOOL)showChargeGames;

/**
 *  充值中心 游戏URL
 */
- (NSString *)chargeGamesURL;

/**
 *	功能:首页tabbar背景信息
 */
-(AppFunctionSwitchVO *)indexBgPicTabVO;

/**
 *	功能:首页刷新背景信息
 */
-(AppFunctionSwitchVO *)indexBgPicRefreshVO;

/**
 *	功能:首页导航栏背景信息
 */
-(AppFunctionSwitchVO *)indexBgPicSearchVO;

/**
 *	功能:首页功能入口背景信息
 */
-(AppFunctionSwitchVO *)indexBgPicIconVO;

/**
 *	功能:剁手价分享信息
 */
-(AppFunctionSwitchVO *)cutListShare;

/**
 *	功能:结算页积分板开关
 */
- (BOOL)billBoardState;

/**
 *  功能：个人中心->我的应用相关信息
 */
-(AppFunctionSwitchVO *)APP_LABVO;

@end
