//
//  Promotion.h
//  OneStore
//
//  Created by huang jiming on 13-8-8.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponPromotion : OTSValueObject

@property(nonatomic, retain) NSNumber *buyMore;//
@property(nonatomic, retain) NSNumber *conditionValue;//

//（换购--> 13：部分满x件可换购,14：部分满x元可换购;  赠品--> 3:单品满x件送y件,5:全场满x元送赠品,11:部分满x件送赠品,12:部分满x元送赠品）
@property(nonatomic, retain) NSNumber *contentType;//促销类型

@property(nonatomic, retain) NSNumber *contentValue;//
@property(nonatomic, retain) NSString *displayName;//显示用的名字
@property(nonatomic, retain) NSMutableArray *mainPmInfoIds;//促销主品PMID列表，list<long>
@property(nonatomic, retain) NSNumber *merchantId;//商家ID
@property(nonatomic, retain) NSNumber *promotionId;//促销ID
@property(nonatomic, retain) NSNumber *promotionLevelId;//促销LEVELID

@property (nonatomic, strong) NSMutableArray *redemptionList;//换购促销下的换购商品 list<PromotionRedemption>
/**换购品选择方式 1全选,2只选一个 */
@property(nonatomic, retain) NSNumber *redemptionSelectType;

@end
