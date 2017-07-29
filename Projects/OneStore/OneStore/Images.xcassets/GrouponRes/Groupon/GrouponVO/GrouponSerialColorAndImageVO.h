//
//  SerialColorAndImageVO.h
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponSerialColorAndImageVO : OTSValueObject

@property (nonatomic, strong) NSString *color;  //颜色
@property (nonatomic, strong) NSString *defaultPicUrl; // 图片url

@end
