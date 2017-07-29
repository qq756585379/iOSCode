//
//  MerchantRateCommentary.m
//  OneStore
//
//  Created by 江 立 on 13-9-13.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "GrouponMerchantRateCommentary.h"

@implementation GrouponMerchantRateCommentary

-(GrouponMerchantRateCommentaryV2 *)rateCommentarVO
{
	GrouponMerchantRateCommentaryV2 *rateCommentarVO = [[GrouponMerchantRateCommentaryV2 alloc] init];
	rateCommentarVO.descriptExpPoint = self.descriptExactExpPoint;
	rateCommentarVO.attitudeExpPoint = self.attitudeExactExpPoint;
	rateCommentarVO.logisticsExpPoint = self.logisticsExactExpPoint;
	rateCommentarVO.descriptStatus = self.descriptStatus;
	rateCommentarVO.attitudeStatus = self.attitudeStatus;
	rateCommentarVO.logisticsStatus = self.logisticsStatus;
	rateCommentarVO.descriptDiffer = self.descriptDiffer;
	rateCommentarVO.logisticsDiffer = self.logisticsDiffer;
	rateCommentarVO.attitudeDiffer = self.attitudeDiffer;
	return rateCommentarVO;
}

@end
