
//
//  MerchantInfoVO.m
//  TheStoreApp
//
//  Created by xuexiang on 12-11-30.
//
//

#import "GrouponMerchantInfoVO.h"

@implementation GrouponMerchantInfoVO
@synthesize rateCommentarVO = _rateCommentarVO;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.merchantName forKey:@"merchantName"];
    [aCoder encodeObject:self.freightInformation forKey:@"freightInformation"];
    [aCoder encodeObject:self.shippingMethod forKey:@"shippingMethod"];
    [aCoder encodeObject:self.paymentMethod forKey:@"paymentMethod"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.merchantName = [aDecoder decodeObjectForKey:@"merchantName"];
    self.freightInformation = [aDecoder decodeObjectForKey:@"freightInformation"];
    self.shippingMethod = [aDecoder decodeObjectForKey:@"shippingMethod"];
    self.paymentMethod = [aDecoder decodeObjectForKey:@"paymentMethod"];
    return self;
}

- (NSString *)freightInformation
{
    if (_freightInformation) {
        NSArray *temp1 = [_freightInformation componentsSeparatedByString:@","];
        NSArray *temp2 = [[temp1 safeObjectAtIndex:0] componentsSeparatedByString:@"，"];
        NSArray *temp3 = [[temp2 safeObjectAtIndex:0] componentsSeparatedByString:@" "];
        NSArray *temp4 = [[temp3 safeObjectAtIndex:0] componentsSeparatedByString:@"　"];
        return [temp4 safeObjectAtIndex:0];
    }
    return _freightInformation;
    
}

- (GrouponMerchantRateCommentaryV2 *)rateCommentarVO
{
    if (_rateCommentarVO == nil) {
        _rateCommentarVO = [[GrouponMerchantRateCommentaryV2 alloc] init];
        _rateCommentarVO.descriptExpPoint = @(4.8);//商品描述评分
        _rateCommentarVO.attitudeExpPoint = @(4.8);//服务态度评分
        _rateCommentarVO.logisticsExpPoint = @(4.8);//配送物流评分
        _rateCommentarVO.descriptStatus = @(3);//描述 1:高于 2:低于 3:等于
        _rateCommentarVO.attitudeStatus = @(3);//服务态度 1:高于 2:低于 3:等于
        _rateCommentarVO.logisticsStatus = @(3);//配送物流  1:高于 2:低于 3:等于
    }
    return _rateCommentarVO;
}

@end

