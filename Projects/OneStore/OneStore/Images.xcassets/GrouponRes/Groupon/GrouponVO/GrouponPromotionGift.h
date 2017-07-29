//
//  PromotionGift.h
//  OneStore
//
//  Created by huang jiming on 13-8-12.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GrouponPromotion;
@class ProductVO;

@interface GrouponPromotionGift : OTSValueObject

@property(nonatomic, retain) NSNumber *merchantId;//商家ID
@property(nonatomic, retain) NSString *name;//商品中文名
@property(nonatomic, retain) NSNumber *num;//数量
@property(nonatomic, retain) NSNumber *originalPrice;//1号店原价
@property(nonatomic, retain) NSString *pic;//图片路径
@property(nonatomic, retain) NSNumber *pmId;//PMID
@property(nonatomic, retain) NSNumber *productId;//商品ID
@property(nonatomic, retain) NSNumber *productType;//产品类型 0：普通产品 1：主系列产品 2：子系列产品 3：捆绑产品 4：实物礼品卡 5: 虚拟商品 6:增值服务 7:电子礼品卡
@property(nonatomic, retain) GrouponPromotion *promotion;//促销信息
@property(nonatomic, retain) NSNumber *soldOut;//是否已经领完，true/false

#pragma mark - 客户端字段
@property(nonatomic, assign) BOOL selected;//是否勾选，用于多选1标示已选中

- (ProductVO *)toProduct;

@end
