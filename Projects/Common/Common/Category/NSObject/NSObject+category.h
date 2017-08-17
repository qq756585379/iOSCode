//
//  NSObject+category.h
//  Common
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (category)

@property (nonatomic, strong, readonly) NSMutableArray *associatedObjectNames;

/**
 *  为当前object动态增加分类
 *
 *  @param propertyName   分类名称
 *  @param value  分类值
 *  @param policy 分类内存管理类型
 */
- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy;

/**
 *  获取当前object某个动态增加的分类
 *
 *  @param propertyName 分类名称
 *
 *  @return 值
 */

- (id)objc_getAssociatedObject:(NSString *)propertyName;

/**
 *  删除动态增加的所有分类
 */
- (void)objc_removeAssociatedObjects;

@end
