//
//  GrouponVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponAbroadBuyOut.h"
#import "GrouponSerialVO.h"

typedef enum {
    GrouponTypeDefault = 0,
    GrouponTypeSelling = 100,
    GrouponTypeSellingSuccess = 101,
    GrouponTypeSellingOvercrowd = 102,
    GrouponTypeEndFailure = 200,
    GrouponTypeEndSuccess = 201,
    GrouponTypeConvertToDO = 202,
    GrouponTypeUnderStock = -1,
    GrouponTypeComingSoon = 50
}GrouponType;

@interface GrouponVO : NSObject

@property(nonatomic, retain) NSNumber *areaId;//地区id
@property(nonatomic, strong) NSNumber *nid;//团购id
@property(nonatomic, strong) NSNumber *id;//品牌抢购id
@property(nonatomic, retain) NSString *name;//团购副标题
@property(nonatomic, strong) NSString *shortName;//团购主标题
@property(nonatomic, strong) NSNumber *categoryId;//团购分类id 101:掌上专享
@property(nonatomic, retain) NSNumber *channelId;// channelId == 102时表示是无线专享价；
@property(nonatomic, strong) NSNumber *secCategoryId; //团购二级分类id
@property(nonatomic, retain) NSDate *startTime;//开始时间
@property(nonatomic, retain) NSDate *endTime;//结束时间
@property(nonatomic, strong) NSNumber *merchantId;//商家id
@property(nonatomic, strong) NSNumber *productId;//商品id
@property(nonatomic, strong) NSNumber *pmInfoId; //商品pmId
@property(nonatomic, retain) NSNumber *discount;//折扣
@property(nonatomic, strong) NSNumber *origionalPrice; //团购原价
@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, retain) NSNumber *peopleLower;//团购下限
@property(nonatomic, retain) NSNumber *peopleUpper;//团购上限
@property(nonatomic, retain) NSNumber *limitLower;//团购商品下限
@property(nonatomic, retain) NSNumber *limitUpper;//团购商品上限
@property(nonatomic, retain) NSString *promotions;//团购提示
/**
 *  团购状态 0初始化 100:团购中 101:团购中-成功 102:团购中-人数满 200:结束-失败 201:结束-成功
 *   202:可转DO  -1: 代表库存不足 50:代表即将开团
 *
 */
@property(nonatomic, retain) NSNumber *status;
@property(nonatomic, retain) NSNumber *peopleNumber;//实际参团人数
@property(nonatomic, strong) NSNumber *orderNumber; //下单个数
@property(nonatomic, retain) NSString *miniImageUrl;//团购首页图片
@property(nonatomic, retain) NSString *middleImageUrl;//团购详情页图片
@property(nonatomic, retain) NSNumber *siteType;//1为1号店，2为1号商场，3为sam卖场
#pragma mark - 海购商品
@property(nonatomic, retain) GrouponAbroadBuyOut * abroadBuyOut;//团购海购出参

/**
 * 0:快捷下单 1、购物车 2、一键购 addCart(Router)只处理购物车和一键购
 */
@property(nonatomic, retain) NSNumber *isIntoCart;
@property(nonatomic, retain) NSNumber *grouponBrandId;//是否是品牌团，0或1；
@property(nonatomic, retain) NSNumber *groupId;
@property (nonatomic,copy) NSString *imageDetail;//主图

@property(nonatomic, retain) NSNumber *freeShipType;   // 0,不显示 包邮信息；1包邮；2满额包邮; 3全国包邮
@property(nonatomic, strong) NSNumber *reserveNumber;//收藏人数、预约人数
@property(nonatomic, retain) NSNumber *isGrouponSerial;//是否为系列产品 1是 0否
@property(nonatomic, strong) NSNumber *todayStart; //是否为今日上新
@property(nonatomic, strong) NSNumber *mobilePrice; //掌上价
@property(nonatomic, strong) NSNumber *clientType; //销售类型 0.全部，1.pc，2.手机
/**
 *       h5 详情url
 */
@property(nonatomic, strong) NSString *h5DetailUrl;
@property(nonatomic, strong) NSNumber *productRate; //Integer 好评率
@property(nonatomic, strong) NSNumber *stockAvailable; //0无库存，1有库存
@property(nonatomic, strong) NSNumber *hourbuyType; //整点抢类型 1.团购 2.普通商品  3.闪购
/**
 *  涨价提示字段 1：需要提示 0：不需要提示
 */
@property(nonatomic,strong)NSNumber *priceChangeRemind;
@property(nonatomic, strong) NSString *productCode; //商品编码
@property(nonatomic, strong)NSNumber *savePrice;//节省
@property(nonatomic, retain) NSNumber *saveCost;//节省
@property(nonatomic, retain) NSNumber *remainTime;//团购剩余时间
@property(nonatomic, retain) NSNumber *productNumber;//团购商品数量
@property(nonatomic, retain) NSString *sellingPoint;//团购卖点
@property(nonatomic, retain) NSString *prompt;//团购提示
@property(nonatomic, retain) GrouponSerialVO *grouponSerialVO;//系列产品信息
@property(nonatomic, retain) NSArray<GrouponSerialVO *> *grouponSerials;//团购系列商品列表
@property(nonatomic, retain) NSArray *colorList;//系列产品所有颜色属性集合，list<NSString>
@property(nonatomic, retain) NSArray *sizeList;//系列产品所有尺寸属性集合，list<NSString>
@property(nonatomic, retain) ProductVO *productVO;

@property(nonatomic, retain) NSString *type;//团购类型 -1历史 0当期 1将来

@property(nonatomic, retain) NSString *remarkerPrompt;//团购购买备注的提示信息
@property(nonatomic, retain) NSNumber *isNew;//是否是今日上新，0或1
@property (nonatomic,strong) NSString *subCnName;//商品二级标题，interface version>1.3.1  app version> 3.1.1 存在,可能为空
@property (nonatomic,strong) NSString *tag;//图片左上标记，interface version>1.3.1  app version> 3.1.1 存在,可能为空

@property (nonatomic, strong) NSString *subName;//商品简介

@property(nonatomic, strong) NSNumber *isHot;//是否是爆款 0:不是 1:是

@property(nonatomic, strong)GrouponImageVO *brandGrouponUrl; //团购图片
@property(nonatomic, strong)GrouponExperienceVO *grouponExperienceOut; //置顶评论信息
/**
 * 系列产品所有颜色属性集合
 */
@property(nonatomic, retain) NSArray<GrouponSerialColorAndImageVO> *colorAndImageList; //list <SerialColorAndImageVO>

#pragma mark - 接口改动新加字段
/**
 * pc 价格
 */
@property(nonatomic, strong)NSNumber *pcPrice;

//金牌秒杀品牌抢购
@property (nonatomic, assign) NSInteger objectType;
@property (nonatomic, strong) NSString *appDetailUrl;
@property (nonatomic, assign) NSInteger brandShowType;

/**
 * 无理由退换货天数 0：不支持无理由退换货， 7：支持7天无理由退换货，15：支持15天无理由退换货..等等
 */
@property(nonatomic, strong)NSNumber *returnDaysReasonless;
@property(nonatomic, strong)NSString *dayReasonlessH5String;
/**
 * 店铺评分
 */
@property(nonatomic, strong)GrouponMerchantRateComentaryVO *grouponMerchantRateComentaryOut;

/**
 * 商家信息
 */
@property(nonatomic, strong)MerchantInfoVO *grouponMerchantInfoOut;


/**
 * 产品图片
 */
@property(nonatomic, strong)NSArray<GrouponProductImageVO> *grouponProductImageOutList;

/**
 *  当前系列商品vo
 */
@property(nonatomic, strong)GrouponSeriesProductVO *currentSeriesProductVO;


@property(nonatomic, strong)GrouponProductOutVO *grouponProductOut; //是否切换属性的参数字典
@property(nonatomic, strong)NSArray<GrouponProductParamOut> *grouponProductParamOutList;//属性参数
@property(nonatomic, strong)NSArray<ProductParamsVo> *grouponProductParamFlashOutList;//属性参数,从闪购接口获得

@property(nonatomic, strong) CouponVo *grouponCouponOut;//抵用券
@property(nonatomic, strong) NSArray<GrouponAttributeVO> *attributeOutList;//List<AttributeVO>封装每个属性项、对应属性值列表，是否颜色属性（新增）
@property(nonatomic, strong) NSArray<GrouponSeriesProductVO> *seriesProductOutList;//List<SerialProductVO>系列商品集合（系列子品pmId、颜色、尺码）（更新属性项ID，属性值Id，pmId）
@property(nonatomic, assign) BOOL isFavorited;//是否收藏
@property(nonatomic, strong) NSNumber *favoriteId;//收藏id



//sam会员团购新增
@property(nonatomic, strong) NSNumber *memberType;//1表示sam商品
@property(nonatomic, strong) NSNumber *currentPriceWithoutBadge;//原价
@property(nonatomic, strong) NSNumber *samMemberPrice;//山姆club的会员价
@property(nonatomic, strong) NSNumber *currentPriceType;//当前价格类型 1:1号店价 2：促销价 3:会员勋章价（sam价）
@property(nonatomic, strong) GrouponSamclubOutVO *grouponSamclubOut;


#pragma mark - 客户端字段
@property(nonatomic, assign) BOOL isSubSeriesProduct;//本地控制是否是系列子品。
@property(nonatomic, assign) BOOL remind;//是否有本地提醒
@property(nonatomic, strong) NSNumber *addToCartCount;//已经添加了多少个
@property(nonatomic, strong) NSMutableDictionary *seriesGrouponVODict;

- (BOOL)isShowSamsEntry;


/**
 *  功能:获取促销类型，转换成枚举
 */
- (GrouponType)theGrouponType;

/**
 *	功能:是否是序列商品
 *
 *	@return
 */
- (BOOL)isSerialProduct;

/**
 *	功能:团购商品是否是掌上专享价格商品
 *
 *	@return
 */
- (BOOL)isWirelessExclusivePirce;

/**
 * 功能:商品是否已经卖光
 *
 *  @return
 */
- (BOOL)isSellout;

/**
 * 功能:判断是否是品牌团购
 *
 * @return
 */
- (BOOL)isGrouponBrand;

/**
 *  功能:是否进购物车
 *
 */
- (BOOL)isIntoCartOrOneKeyBuy;

/**
 *  功能:返回当前团购商品的图片
 *
 */
- (NSString *)findCurrentAttributePicUrl;

/**
 *  功能:判断是否有服务标签需要显示
 *
 */
- (BOOL)isHaveTags;

//评论数组
@property (strong, nonatomic) NSArray *commentArray;
//@property(nonatomic, strong) DProductDetailVO *productDetailVO; //新的商品详情
@property(strong, nonatomic) NSArray<GrouponPromotionOutVO> *grouponPromotionOutList; //满减的数组

@end
