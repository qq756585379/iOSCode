//
//  HomePromotionDetailVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponVO.h"
#import "ProductVO.h"

typedef enum {
    GrouponChannelTypeProduct = 1,       //商品团
    GrouponChannelTypeBrand = 2,         //品牌团
    GrouponChannelTypeTodayNew = 3,      //今日上新
    GrouponChannelTypeCommingSoon = 4    //即将开团
} GrouponChannelType;

typedef enum {
    EnterGroup = 1,                 //进入团购
    EnterShake = 2,                 //进入摇一摇
    EnterLogistics = 3,             //进入物流查询
    EnterRecharge = 4,              //进入手机充值
    EnterLarder = 5,                //进入购物足迹
    EnterRegistration = 6,          //进入签到
    EnterFlashBuy = 7,              //进入闪购
    EnterLoveShare = 9,             //进入爱分享
    EnterShake2 = 13,               //摇一摇V2
    EnterGroupCategory =  14,       //团购分类
    EnterGroupBrand = 15,           //品牌团
    EnterDailyBuy   = 16,           //每日惠
    EnterVirtualBusiness = 17,      //虚拟业务，包括 各种彩票，电影票等
    EnterFlashBuyCategory = 19,     //闪购分类
    EnterFlashBuyMarketplace = 20,  //闪购卖场
    EnterBabyCenter = 24,           //宝宝中心
    EnterFlashBuyDetail = 25        //闪购详情
} FunctionType;//功能入口

typedef enum {
    CMSActivityType = 1,            //CMS活动
    CashType = 2,                   //满减
    GiftType = 3,                   //赠品
    NnType = 4,                     //N元n件
    VouchersType = 5,               //抵用券
    CommodityType = 6,              //商品促销
    GroupType = 7,                  //团购促销
    CMSPromotionType = 8,           //CMS促销活动
    SearchType = 9,                 //搜索类型关键字
    VivasType = 10,                 //品牌旗舰
    BrandShopType = 11 ,            //品牌店铺
    TopUpType = 12,                 //手机充值TYPE
    ImportType = 13,                //进口馆,只有ipad有
    ADWithoutUrl = 14,              //无连接的图片
    ADWithUrl = 15,                 //有链接的图片
    ActionADType = 16,              //功能广告
    BrandADType  = 17,              //品牌广告
    CategoryType = 18,              //类目类型
    StoreADType  = 19,              //店铺广告
    DiscountType = 20,              //满折类型
    GroupCategoryType = 21,         //团购类目类型
    GroupChannelType = 22,          //团购频道
    GroupBrandType   = 23,          //团购品牌
    GroupClusterType = 24,          //团购聚类类型
    SingleProductType = 25,         //单个商品类型(现只有团购单品)
    ProductListType = 26,           //商品列表
    GrouponNativeActivityType = 27, //团购预热
} PromotionType;//促销活动类型

@interface HomePromotionDetailVO : NSObject
@property(nonatomic, strong) NSString *bannerPicture;//活动的图片地址
@property(nonatomic, strong) NSNumber *type;//活动等级
@property(nonatomic, strong) NSString *title;//活动标题
@property(nonatomic, strong) NSString *subTitle;//活动副标题
@property(nonatomic, strong) NSNumber *startTime;
/**
 * 促销活动Id(PC促销活动展示为促销活动的ID，CMS活动表示为CMS活动的viewId,
 * 品牌广告id,类目id,功能类型，店铺id，团购类目ID)
 */

@property(nonatomic, strong) NSNumber *promotionId;//促销活动ID
/**
 *  搜索分类:如果是普通类目:1,虚拟类目:2,关键字类目:3(未支持)
 */
@property(nonatomic, strong) NSNumber *promotionLevelId;//促销活动等级Id
/**
 * 促销活动类型 1.CMS活动； 2.满减 ；3.赠品 ；4.N元n件 ；5.抵用券；6.商品促销；7.团购促销；8.CMS促销活动；9-搜索类型关键字；10-品牌旗舰；11-品牌店铺；12-手机充值；13进口馆；14-无连接广告；15-链接广告 16 功能广告；17 品牌广告；18类目 ；19店铺广告 ;20 满折；21 团购类目；22 团购频道;23 团购品牌;24 团购聚类；25 单品 27 Native CMS活动
 */
@property(nonatomic, strong) NSNumber *promotionType;//PromotionType
@property(nonatomic, strong) NSString *promotionLink;//活动链接
@property(nonatomic, strong) NSArray<ProductVO> *prodcutVOList;//单品列表，ProductVo类型
@property(nonatomic, strong) NSArray<GrouponVO> *grouponVOList;//团购列表 ,GrouponVo类型
@property(nonatomic, strong) NSNumber *hotProductType;/*热销商品类型 1-普通商品,2-团购商品*/

@property(nonatomic, strong) NSString *tracker;//?? 测试环境新加字段
@property(nonatomic, strong) NSString *tc;// 曝光埋点信息
@property(nonatomic, strong) NSString *tce;// 附加字段信息（埋点用）
@property(nonatomic, strong) NSString *tc_e;// 附加字段信息（埋点用）
@property(nonatomic, strong) NSString *tcCode;
@property(nonatomic, strong) NSString *tceCode;

/* keyword, >v1.3.1, 搜索词 或 类目名字  或 店铺名字 或品牌名字 或团购类目名字 或 团购品牌名字 或团购聚类名字  或功能类型 或团购频道类型
 * 团购频道类型为 1 商品团购首页  2 品牌团首页 3 今日上新
 
 * 功能入口类型为  1：1号团   2.摇一摇 3 订单查询  4 手机充值 5 购物足迹  6 签到 7:图片广告类型:8,微信分享,9,爱分享,10,我的一号店(H5)  11,我的购物车(H5)  12,热门类目（H5）13 摇一摇V2, 14,团购分类, 15 品牌团 ,16 每日惠, 17 彩票
 */
@property(nonatomic, strong) NSString *keyword;
/**
 * 素材布局，1 ：一行一个  2：一行两个   3 ：一行三个  version>>v1.3.1存在
 *         4：一行四个
 */
@property(nonatomic, strong) NSNumber *style;

@property(nonatomic, strong) NSString *threeTitles;// 三级标题

/**
 * 是否hot  version>>v1.3.1存在
 * 如果为null或不存在此字段，则非hot标记；否则现实hot标记
 */
@property(nonatomic, strong) NSString *hot;

/**
 * >=v1.3.2  活动图片宽度,如果为0，请使用默认的长宽
 */
@property(nonatomic, strong) NSNumber *bannerPictureWidth;

/**
 *  >=v1.3.2  活动图片长度，如果为0，请使用默认的长宽
 */
@property(nonatomic, strong) NSNumber *bannerPictureHeight;

/**
 *  广告logo图片
 */
@property(nonatomic, strong) NSString *logoPic;

//interface version >1.3.1 and  client version>3.1.1，爱分享等无连接广告类型html数据
@property(nonatomic, strong) NSString *htmlContent;

@property(nonatomic, strong) NSNumber *isSupportApp;//1, 表示 原生的CMS，0 表示cms的栏目中存在 原生CMS不支持的栏目

/**
 *  闪购购物袋倒计时结束时间
 */
@property(nonatomic, strong) NSDate *diaryRemainTimes;
/**
 *  闪购购物袋数量
 */
@property(nonatomic, strong) NSNumber *flushBuyNum;
/**
 *  存放APP跳转页面对应的url
 */
@property (nonatomic, strong) NSString *appLinkUrl;

@property(nonatomic, strong) NSNumber *brandGroupDiscounts;//品牌团广告折扣信息
@property(nonatomic, strong) NSString *brandGroupPicUrl;//品牌团广告折扣信息
// 广告跳转付费URL
@property(nonatomic, strong) NSString *landingPage;

@end
