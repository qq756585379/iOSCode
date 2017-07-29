//
//  PromotionGift.m
//  OneStore
//
//  Created by huang jiming on 13-8-12.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "GrouponPromotionGift.h"
#import "ProductVO.h"
#import "GrouponPromotion.h"

@implementation GrouponPromotionGift

- (ProductVO *)toProduct
{
    ProductVO *productVO = [[ProductVO alloc] init];
//    productVO.pmId = self.pmId;
//    productVO.productId = self.productId;
//    productVO.merchantId=self.merchantId;
//    productVO.promotionId = [NSString stringWithFormat:@"%d_%d_normal", self.promotion.promotionId.intValue, self.promotion.promotionLevelId.intValue];
//    productVO.promotionPrice = __DOUBLE(0.0);
//    productVO.price = __DOUBLE(self.originalPrice.doubleValue);
    
//    productVO.cnName = self.name;
//    productVO.miniDefaultProductUrl = self.pic;
//    productVO.isGift = __INT(1);
    
    return productVO;
}

@end
