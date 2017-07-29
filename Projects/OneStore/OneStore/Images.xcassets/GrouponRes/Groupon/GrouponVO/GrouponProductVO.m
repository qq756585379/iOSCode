//
//  GrouponProductVO.m
//  GrouponProject
//
//  Created by zhangbin on 14-10-10.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponProductVO.h"

@implementation GrouponProductVO

- (NSNumber *)realPrice
{
    NSNumber *realPrice = self.price;
    if ([self isInPromotion] && self.promotionPrice) {
        realPrice = self.promotionPrice;
    }
    if (self.isGift.boolValue) {
        realPrice = @(0.0);
    }
    return realPrice;
}

- (BOOL)isInPromotion
{
    return self.promotionId && [self.promotionId length] > 0;
}

- (BOOL)isYihaodianProduct
{
    if (!self.isYihaodian) {//默认是1号店商品
        return YES;
    }
    return self.isYihaodian.boolValue;
}

- (BOOL )isReturnGrouponProduct
{
    return (self.returnDaysReasonless.integerValue > 0);
}

@end
