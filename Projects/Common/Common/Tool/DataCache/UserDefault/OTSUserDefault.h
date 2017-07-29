//
//  OTSUserDefault.h
//  OneStoreFramework
//
//  Created by Aimy on 14-6-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSUserDefault : NSObject

/**
 *  存储数据到userdefault
 *
 *  @param anObject 数据
 *  @param aKey     标识
 */
+ (void)setValue:(id)anObject forKey:(NSString *)aKey;
/**
 *  从userdefault获取数据
 *
 *  @param aKey 标识
 *
 *  @return 数据
 */
+ (id)getValueForKey:(NSString *)aKey;

/**
 *  存储 bool 值
 *
 *  @param value 数据
 *  @param aKey  key
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)aKey;

/**
 *  从userdefault获取数据
 *
 *  @param aKey key
 */
+ (BOOL)getBoolValueForKey:(NSString *)aKey;

@end
