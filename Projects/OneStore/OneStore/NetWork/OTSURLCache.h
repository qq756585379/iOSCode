//
//  OTSURLCache.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSURLCache : NSURLCache

+ (instancetype)standardURLCache;

/**
 *  功能:根据最新的接口版本号进行处理
 *  param:dict，格式{methodName:version}
 */
- (void)dealWithNewInterfaceVersionDict:(NSDictionary *)versionDict;

@end
