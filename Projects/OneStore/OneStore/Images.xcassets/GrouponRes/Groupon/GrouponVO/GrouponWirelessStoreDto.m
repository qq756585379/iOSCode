//
//  WirelessStoreDto.m
//  OneStore
//
//  Created by 江 立 on 13-9-13.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "GrouponWirelessStoreDto.h"

@implementation GrouponWirelessStoreDto

- (GrouponMerchantInfoVO *)merchantInfoVO
{
	GrouponMerchantInfoVO *merchantInfoVO = [[GrouponMerchantInfoVO alloc] init];
	merchantInfoVO.merchantName = self.storeName;
	merchantInfoVO.freightInformation = self.freeShipping;//运费信息
//	merchantInfoVO.rateCommentarVO = [self.merchantRateCommentary rateCommentarVO];
	return merchantInfoVO;
}

@end
