//
//  SerialAttributeVO.h
//  OneStore
//
//  Created by yuan jun on 14-5-21.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GrouponSeriesAttributeVO <NSObject>

@end

@interface GrouponSeriesAttributeVO : OTSValueObject

@property(nonatomic, strong) NSNumber *attributeId;
@property(nonatomic, strong) NSNumber *attributeValueId;

@end
