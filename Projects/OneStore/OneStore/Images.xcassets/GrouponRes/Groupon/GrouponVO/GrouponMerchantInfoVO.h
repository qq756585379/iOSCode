//
//  MerchantInfoVO.h
//  TheStoreApp
//
//  Created by xuexiang on 12-11-30.
//
//

#import <Foundation/Foundation.h>
#import "GrouponMerchantRateCommentaryV2.h"

@interface GrouponMerchantInfoVO : OTSValueObject<NSCoding>

@property(nonatomic, retain) NSString *merchantName; // XML解析字段
@property(nonatomic, retain) NSString *freightInformation;//运费信息
@property(nonatomic, retain) NSString *shippingMethod;//配送方式
@property(nonatomic, retain) NSString *paymentMethod;//支付方式
@property(nonatomic, strong) GrouponMerchantRateCommentaryV2 *rateCommentarVO;//商品评分等级信息

@end
