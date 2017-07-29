//
//  OrderVO.m
//  ProtocolDemo
//
//  Created by vsc on 11-2-12.
//  Copyright 2011 vsc. All rights reserved.
//

#import "GOrderVO.h"
#import "GrouponOrderItemVO.h"
#import "GrouponProductVO.h"

@implementation GOrderVO


#pragma mark- Interfaceface
-(BOOL)idcommunityproduct
{
    if ([self.businessType isEqual:@(20)]) {
        return YES;
    }
    return NO;
}

- (BOOL)isCanPay
{
	if (self.orderStatus.integerValue == 3
		&& [self.paymentMethodForString isEqualToString:@"网上支付"]) {
		return YES;
	}
	return NO;
}
-(NSString*)orderStatusForString{
    return _orderStatusForString;
}

- (NSString *)orderPayPriceString
{
    
    NSString *payString;
   
    payString = [NSString stringWithFormat:@"%.2f", self.orderAmount.doubleValue-self.couponAmount.doubleValue-self.cardAmount.doubleValue-self.accountAmount.doubleValue];

    
    return payString;
}

- (NSString *)productPriceString
{
    NSString *priceString;
    priceString = [NSString stringWithFormat:@"%.2f", self.productAmount.floatValue-self.cashAmount.floatValue];
    return priceString;
    
}

- (NSString *)pointString
{
    NSString *pointString;
    NSInteger point = 0;
    
    for (GrouponOrderItemVO *orderItemVO in self.orderItemList) {
        GrouponProductVO *product = orderItemVO.product;
        point += product.activitypoint.intValue * orderItemVO.buyQuantity.intValue;
    }
    
    if (point > 0) {
        pointString = [NSString stringWithFormat:@"%ld",(long)point];
    } else {
        pointString = nil;
    }
    
    return pointString;
}

- (NSString *)leftDateDescribe
{
	NSMutableString *leftDateInfo = [[NSMutableString alloc] init];
	if (self.lefthours) {
		[leftDateInfo appendString:[NSString stringWithFormat:@"%d小时",self.lefthours.intValue]] ;
	}
	if (self.leftminite) {
		[leftDateInfo appendString:[NSString stringWithFormat:@"%d分钟",self.leftminite.intValue]] ;
	}else if(self.lefthours){
		[leftDateInfo appendString:@"0分钟"];
	}
	return leftDateInfo;
}


- (NSNumber *)payAccount
{
	return @( self.orderAmount.doubleValue
		- self.couponAmount.doubleValue
	    - self.cardAmount.doubleValue
	    - self.accountAmount.doubleValue);
}

- (NSNumber *)needPayAccount
{
	return @(self.orderAmount.doubleValue
			- self.couponAmount.doubleValue
			- self.cardAmount.doubleValue
			- self.accountAmount.doubleValue);
}
/**
 *	订单支付成功后,此订单的金额
 *
 *	@return
 */
- (NSNumber *)orderAccount
{
	return @( self.orderAmount.doubleValue
			 - self.couponAmount.doubleValue
		     - self.cardAmount.doubleValue);
}

@end
