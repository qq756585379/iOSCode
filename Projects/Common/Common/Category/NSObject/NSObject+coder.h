//
//  NSObject+coder.h
//  OneStoreFramework
//
//  Created by Aimy on 14-7-20.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (coder)
/**
 *  快捷从归档恢复方法
 */
- (id)otsDecodeWithCoder:(NSCoder *)aDecoder;
/**
 *  快捷归档方法
 */
- (void)otsEncodeWithCoder:(NSCoder *)aCoder;

@end
