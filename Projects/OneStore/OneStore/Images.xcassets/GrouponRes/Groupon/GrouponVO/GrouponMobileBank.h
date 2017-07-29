//
//  MobileBank.h
//  OneStore
//
//  Created by wuyicheng on 13-8-23.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface GrouponMobileBank : OTSValueObject

@property(nonatomic, strong) NSString *description;   //描述
@property(nonatomic, strong) NSNumber *nid;           //唯一id
@property(nonatomic, strong) NSString *imgSrc;        //logo URL
@property(nonatomic, strong) NSString *name;          //名称
@property(nonatomic, strong) NSString *code;
@end
