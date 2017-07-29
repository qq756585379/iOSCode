//
//  GrouponSerialVO.h
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GrouponSerialVO <NSObject>

@end

@interface GrouponSerialVO : OTSValueObject

@property(nonatomic, retain) NSNumber *nid;//团购系列产品id
@property(nonatomic, retain) NSNumber *grouponId;//团购id
@property(nonatomic, retain) NSNumber *mainProductId;//主系列产品id
@property(nonatomic, retain) NSNumber *subProductId;//子系列产品id
@property(nonatomic, retain) NSString *productColor;//产品颜色
@property(nonatomic, retain) NSString *productSize;//产品尺寸
@property(nonatomic, retain) NSNumber *upperSaleNum;//最高购买数
@property(nonatomic, retain) NSNumber *boughtNum;//已经出售数
@property(nonatomic, retain) NSNumber *pmId;//ipad加入购物车需要的id字段
@property(nonatomic, retain) NSNumber *stockAvailable;//1.有库存，0.没库存
@property(nonatomic, strong) NSNumber *price; //子品价格
@property(nonatomic, strong) NSNumber *channelId; //channelId ==102 为无线专享价

/**
 *	功能:团购商品是否是掌上专享价格商品
 *
 *	@return
 */
- (BOOL)isWirelessExclusivePirce;
@end

