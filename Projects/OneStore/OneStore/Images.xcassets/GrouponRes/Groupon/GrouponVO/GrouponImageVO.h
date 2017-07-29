//
//  GrouponImageVO.h
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponImageVO : OTSValueObject

@property(nonatomic, strong)NSString * url; //图片url
@property(nonatomic, strong)NSNumber *scale; //图片比例;
@end
