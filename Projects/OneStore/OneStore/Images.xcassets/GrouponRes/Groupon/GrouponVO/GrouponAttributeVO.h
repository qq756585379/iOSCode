//
//  AttributeVo.h
//  OneStore
//
//  Created by airspuer on 14-5-15.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponAttributeValueVO.h"
@protocol GrouponAttributeVO


@end
@interface GrouponAttributeVO : OTSValueObject<NSCoding>

@property(nonatomic, strong)NSNumber * attributeId;//属性项ID
@property(nonatomic, strong)NSString *attributeName; //属性项名称
@property(nonatomic, strong)NSArray<GrouponAttributeValueVO> *attributeValueVOList;	//List<AttributeValueVO>	属性值列表
@property(nonatomic, strong)NSNumber *attributeType;	//2：颜色属性（需要展示成图片）

@end
