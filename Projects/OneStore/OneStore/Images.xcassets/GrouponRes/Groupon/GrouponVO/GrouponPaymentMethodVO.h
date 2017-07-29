//
//  PaymentMethodVO.h
//  TheStoreApp
//
//  Created by jiming huang on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponPaymentMethodError.h"

@interface GrouponPaymentMethodVO : OTSValueObject

@property(retain, nonatomic) GrouponPaymentMethodError *errorInfo;//不支持货到付款的原因
@property(retain, nonatomic) NSNumber *gatewayId;//支付网关id，仅支付方式id为网上支付时有效
@property(retain, nonatomic) NSString *gatewayImageUrl;//支付网关图片地址，仅支付方式id为网上支付时有效
@property(retain, nonatomic) NSString *gatewayName;//支付网关名称，仅支付方式id为网上支付时有效
@property(retain, nonatomic) NSNumber *isDefaultPaymentMethod;//是否默认支付方式，true是，false否
@property(retain, nonatomic) NSNumber *isSupport;//是否支持货到付款. true/false
@property(retain, nonatomic) NSNumber *methodId;//支付方式id
@property(retain, nonatomic) NSString *methodName;//支付方式名称
@property(retain, nonatomic) NSNumber *paymentType;//支付方式类型
@property(retain, nonatomic) NSString *reverse;//保留字段

@end
