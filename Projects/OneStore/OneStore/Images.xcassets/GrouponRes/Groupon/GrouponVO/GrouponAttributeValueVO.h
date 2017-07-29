//
//  GrouponAttributeValueVO.h
//  OneStore
//
//  Created by airspuer on 14-5-15.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GrouponAttributeValueVO


@end
@interface GrouponAttributeValueVO : OTSValueObject<NSCoding>

@property(nonatomic, strong)NSNumber *attributeId;
@property(nonatomic, strong)NSNumber *attributeValueId; //属性值Id
@property(nonatomic, strong)NSString *attributeValueName; //属性值Name
@property(nonatomic, strong)NSString *attributeValueAlias;//属性值别名
@property(nonatomic, strong)NSString *attributePicUrl; //属性图片地址
@property(nonatomic, strong)NSString *smallPicUrl;//团购图片

@end
