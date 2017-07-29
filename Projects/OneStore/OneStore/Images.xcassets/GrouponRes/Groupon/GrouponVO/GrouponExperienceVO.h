//
//  GrouponExperienceVO.h
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponExperienceVO : OTSValueObject

@property(nonatomic, strong) NSNumber *experienceCount; //评论总数
@property(nonatomic, strong) NSString *content; //评论内容
@property(nonatomic, strong) NSNumber *productRate; //好评率
@property(nonatomic, strong) NSNumber *hasPic;//是否有评论图片
@property(nonatomic, strong) NSNumber *score; //评论分数

@end
