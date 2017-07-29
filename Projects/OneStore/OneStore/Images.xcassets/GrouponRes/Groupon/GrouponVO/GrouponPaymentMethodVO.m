//
//  PaymentMethodVO.m
//  TheStoreApp
//
//  Created by jiming huang on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "GrouponPaymentMethodVO.h"

@implementation GrouponPaymentMethodVO

@synthesize errorInfo;//不支持货到付款的原因
@synthesize gatewayId;//支付网关id，仅支付方式id为网上支付时有效
@synthesize gatewayImageUrl;//支付网关图片地址，仅支付方式id为网上支付时有效
@synthesize gatewayName;//支付网关名称，仅支付方式id为网上支付时有效
@synthesize isDefaultPaymentMethod;//是否默认支付方式，TRUE 是， FALSE 否
@synthesize isSupport;//是否支持货到付款. true/false
@synthesize methodId;//支付方式id
@synthesize methodName;//支付方式名称
@synthesize paymentType;//支付方式类型
@synthesize reverse;//保留字段

@end
