//
//  MerchantRateCommentary.h
//  OneStore
//
//  Created by 江 立 on 13-9-13.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponMerchantRateCommentaryV2.h"
@interface GrouponMerchantRateCommentary : OTSValueObject

@property (nonatomic ,strong) NSNumber *nid;
@property (nonatomic ,strong) NSNumber *merchantId;
@property (nonatomic ,strong) NSNumber *descriptExactExpPoint;//描述相符精确评分
@property (nonatomic ,strong) NSNumber *attitudeExactExpPoint;//服务态度精确评分
@property (nonatomic ,strong) NSNumber *logisticsExactExpPoint;//发货速度精确评分
@property (nonatomic ,strong) NSNumber *descriptStatus;//描述 低 高 等
@property (nonatomic ,strong) NSNumber *attitudeStatus;//态度 低 高 等
@property (nonatomic ,strong) NSNumber *logisticsStatus;//速度 低 高 等
@property (nonatomic ,strong) NSNumber *descriptDiffer;//描述与同行业比值
@property (nonatomic ,strong) NSNumber *attitudeDiffer;//态度与同行业比值
@property (nonatomic ,strong) NSNumber *logisticsDiffer;//速度与同行业比值
@property (nonatomic ,strong) NSDate *createTime;//创建时间
@property (nonatomic ,strong) NSDate *updateTime;//更新时间

/**
 *	功能:
 *
 *	@return 转换店铺评分信息
 */
-(GrouponMerchantRateCommentaryV2 *)rateCommentarVO;
@end
