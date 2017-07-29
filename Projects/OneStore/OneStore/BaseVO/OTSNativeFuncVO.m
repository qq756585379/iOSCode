//
//  OTSNativeFuncVO.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSNativeFuncVO.h"

@implementation OTSNativeFuncVO

+ (instancetype)createWithBlock:(OTSNativeFuncVOBlock)block{
    OTSNativeFuncVO *vo = [self new];
    vo.block = block;
    return vo;
}

@end
