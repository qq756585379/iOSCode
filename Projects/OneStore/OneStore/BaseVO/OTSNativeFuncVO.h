//
//  OTSNativeFuncVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSBlock.h"
#import "OTSEnum.h"

@interface OTSNativeFuncVO : NSObject
/**
 *  调用的方法,默认传送一个参数，为NSDictionary
 */
@property (nonatomic, copy) OTSNativeFuncVOBlock block;
/**
 *  func过滤
 */
@property (nonatomic) OTSMappingClassPlatformType funcFilterType;
/**
 *  调用此方法需要先登陆
 */
@property (nonatomic) BOOL needLogin;

+ (instancetype)createWithBlock:(OTSNativeFuncVOBlock)block;

@end
