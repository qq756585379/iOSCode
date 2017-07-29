//
//  GrouponBrandVO.h
//  OneStore
//
//  Created by songdong on 13-10-21.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponImageVO.h"

@protocol GrouponBrandVO <NSObject>

@end

@interface GrouponBrandVO : OTSValueObject

@property(nonatomic) NSInteger nid;
@property(nonatomic, strong) NSDate *endTime;
@property(nonatomic, strong) NSDate *startTime;
@property(nonatomic, strong) NSString *imageBrandUrl;
@property(nonatomic, strong) NSString *imageTuanUrl;     //右边团的图片
@property(nonatomic, strong) NSString *imageLogoUrl;     //logo图片
@property(nonatomic, strong) NSString *imageMobileUrl;
@property(nonatomic, strong) NSNumber *peopleNumber;   //参团人数
@property(nonatomic, strong) NSNumber *rebate;   //折扣
@property(nonatomic, strong) NSString *shortName;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSNumber *isNew;
@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSNumber *categoryId;

@property(nonatomic, strong) GrouponImageVO *brandUrl;
@property(nonatomic, strong) GrouponImageVO *logoUrl;

@end
