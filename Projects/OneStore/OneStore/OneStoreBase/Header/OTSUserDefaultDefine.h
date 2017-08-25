//
//  OTSUserDefaultDefine.h
//  OneStoreFramework
//
//  Created by Aimy on 14-6-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

static NSString *const OTS_NETWORK_ENVIROMNMENT              = @"OTS_NETWORK_ENVIROMNMENT";

static NSString *const BI_SessionId                          = @"BI_SessionId";
static NSString *const BI_SessionTimeOut                     = @"BI_SessionTimeOut";
static NSString *const BI_OpenTrucku                         = @"BI_OpenTrucku";
static NSString *const BI_BIcheckIsOpen                      = @"BI_BIcheckIsOpen";  //埋点校验开关

//摇一摇截屏开关
static NSString *const OTS_SCREENSHOT_IS_CLOSE               = @"OTS_SCREENSHOT_IS_CLOSE";

static NSString *const OTS_DEF_KEY_SAVED_PROVINCE            = @"OTS_DEF_KEY_SAVED_PROVINCE";//省份id
static NSString *const OTS_DEF_KEY_SAVED_PROVINCE_NAME       = @"OTS_DEF_KEY_SAVED_PROVINCE_NAME";//省份名称
static NSString *const OTS_DEF_KEY_LOCATION_CITYNAME         = @"OTS_DEF_KEY_LOCATION_CITYNAME";//定位的城市名字，和其他无关
static NSString *const OTS_DEF_KEY_CURRENT_CITYID            = @"OTS_DEF_KEY_CURRENT_CITYID";//cityid
static NSString *const OTS_DEF_KEY_SESSION_ID                = @"OTS_DEF_KEY_SESSION_ID";//session id
static NSString *const OTS_DEF_KEY_LAST_RUN_VERSION          = @"OTS_DEF_KEY_LAST_RUN_VERSION";//for first lunch

//爱分享
static NSString *const OTS_DEF_KEY_HIDE_ISHARE_GUIDER        = @"OTS_DEF_KEY_HIDE_ISHARE_GUIDER";//隐藏爱分享首页引导
static NSString *const OTS_DEF_KEY_HIDE_ISHARE_SELECT_GUIDER = @"OTS_DEF_KEY_HIDE_ISHARE_SELECT_GUIDER";//隐藏爱分享抵用券选择页引导

//登录
static NSString *const UserDefaultAutoLogin = @"userdefault.passport.autoLogin";

//更新有奖
static NSString *const OTS_DEF_KEY_HAVE_CREATED_MESSAGE      = @"OTS_DEF_KEY_HAVE_CREATED_MESSAGE";//版本更新是否已创建消息

//apollo
static NSString *const OTS_DEF_KEY_APOLLO_URL_STRING         = @"OTS_DEF_KEY_APOLLO_URL_STRING";//apollo
static NSString *const OTS_DEF_KEY_REGION_TYPE               = @"OTS_DEF_KEY_REGION_TYPE";//normal,apollo,walmart

//地址
static NSString *const OTS_ADDRESS_VERSION                   = @"OTS_ADDRESS_VERSION";

static NSString *const OTS_DEF_KEY_ABTEST                    = @"OTS_DEF_KEY_ABTEST";//ABTest的key

//打标可配置相关
static NSString *const OTS_APP_TAG_VERSION                   = @"OTS_APP_TAG_VERSION"; //规则版本
static NSString *const OTS_APP_TAG_REDUCE_CODE               = @"#10001"; //满减
static NSString *const OTS_APP_TAG_DISCOUNT_CODE             = @"#10002"; //满折
static NSString *const OTS_APP_TAG_GIFT_CODE                 = @"#10003"; //满赠
static NSString *const OTS_APP_TAG_SALE_CODE                 = @"#10004"; //优惠
static NSString *const OTS_APP_TAG_INTEGRATE_CODE            = @"#10005"; //积分购
static NSString *const OTS_APP_TAG_GROUPON_CODE              = @"#20001"; //团购价
static NSString *const OTS_APP_TAG_FLASH_CODE                = @"#20002"; //闪购价
static NSString *const OTS_APP_TAG_LP_CODE                   = @"#20003"; //LP
static NSString *const OTS_APP_TAG_WIRELESS_CODE             = @"#20004"; //无线专享
static NSString *const OTS_APP_TAG_PRESELL_CODE              = @"#20005"; //全款预售
static NSString *const OTS_APP_TAG_CHANGE_CODE               = @"#20006"; //换购价
static NSString *const OTS_APP_TAG_MEDAL_CODE                = @"#20007"; //勋章价
static NSString *const OTS_APP_TAG_VIP_CODE                  = @"#20008"; //会员价
static NSString *const OTS_APP_TAG_JD_CODE                   = @"#20009"; //低京东
static NSString *const OTS_APP_TAG_LOWEST_CODE               = @"#20010"; //一贵就赔
static NSString *const OTS_APP_TAG_MEDAL_OR_VIP_CODE         = @"#20011"; //VIP或勋章价 购物车的
static NSString *const OTS_APP_TAG_REDUCE_PRICE_CODE         = @"#20012"; //降价 买过的




