//
//  GrouponProductVO.h
//  GrouponProject
//
//  Created by zhangbin on 14-10-10.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "ProductVO.h"

@interface GrouponProductVO : ProductVO

@property(nonatomic, retain) NSNumber *activitypoint; //活动积分
@property(nonatomic, strong) NSNumber *priceChangeRemind;// 价格防呆 0不需要 1需要
@property(nonatomic, retain) NSNumber *ruleType; // 团购=2
@property(nonatomic, retain) NSNumber *isOnekeySales;//是否是一键购商品
@property(nonatomic, retain) NSNumber *isGift;//商品是否为赠品，1表示为赠品，0表示否，主要用于在订单中标识是否为赠品
@property(nonatomic, retain) NSString *promotionId;//商品促销id信息
@property(nonatomic, retain) NSNumber *isYihaodian;//是否是1号店，0:否 1:是
/**
 * 无理由退货天数 0：不支持无理由退货， 7：支持7天无理由退货，15：支持15天无理由退货..等等 （团购）
 */
@property(nonatomic, strong)NSNumber *returnDaysReasonless;
@property(nonatomic, assign) BOOL remind;//是否有本地提醒

/**
 *	功能:商品的真实价格
 *       促销商品时为促销价
 *
 *	@return
 */
- (NSNumber *)realPrice;

/**
 *	功能:判断此商品是否是促销商品
 *
 *	@return
 */
- (BOOL)isInPromotion;

/**
 *	功能:判断此商品是否是yhd商品
 *
 *	@return
 */
- (BOOL)isYihaodianProduct;

/**
 *	功能:团购商品是否支持退换货
 *
 *	@return
 */
- (BOOL)isReturnGrouponProduct;

@end
