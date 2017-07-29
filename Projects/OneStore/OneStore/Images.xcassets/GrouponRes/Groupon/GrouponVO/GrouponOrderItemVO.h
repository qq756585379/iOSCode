//
//  OrderItemVO.h
//  ProtocolDemo
//
//  Created by vsc on 11-2-12.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GrouponProductVO;

@interface GrouponOrderItemVO : OTSValueObject

@property(retain, nonatomic) NSNumber *buyQuantity;//购买数量
@property(retain, nonatomic) GrouponProductVO *product;//产品
@property(retain, nonatomic) NSNumber *ruleType;

@end
