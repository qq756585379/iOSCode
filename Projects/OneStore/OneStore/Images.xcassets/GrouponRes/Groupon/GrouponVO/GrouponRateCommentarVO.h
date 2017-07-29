//
//  RateCommentarVO.h
//  OneStore
//
//  Created by airspuer on 13-8-25.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponRateCommentarVO : OTSValueObject

@property(nonatomic, retain) NSNumber *descriptExpPoint;//商品描述评分
@property(nonatomic, retain) NSNumber *attitudeExpPoint;//服务态度评分
@property(nonatomic, retain) NSNumber *logisticsExpPoint;//配送物流评分
@property(nonatomic, retain) NSNumber *descriptStatus;//描述 1:高于 2:低于 3:等于
@property(nonatomic, retain) NSNumber *attitudeStatus;//服务态度 1:高于 2:低于 3:等于
@property(nonatomic, retain) NSNumber *logisticsStatus;//配送物流  1:高于 2:低于 3:等于
@property(nonatomic, retain) NSNumber *descriptDiffer;//商品描述评分差
@property(nonatomic, retain) NSNumber *attitudeDiffer;//服务态度评分差
@property(nonatomic, retain) NSNumber *logisticsDiffer;//配送物流评分差

@end
