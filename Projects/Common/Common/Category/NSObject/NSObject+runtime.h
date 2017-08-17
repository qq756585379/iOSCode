//
//  aaa.h
//  OneStoreFramework
//
//  Created by Aimy on 14-7-20.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

/**
 *  获取对象的所有属性
 *
 *  @return 属性dict
 */
- (NSArray *)getProperties;

@end
