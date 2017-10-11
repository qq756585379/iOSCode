//
//  NSObject+category.m
//  Common
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "NSObject+category.h"
#import <objc/runtime.h>
#import "CommonDefine.h"
#import "LogDefine.h"

@implementation NSObject (category)

static char associatedObjectNamesKey;

- (void)setAssociatedObjectNames:(NSMutableArray *)associatedObjectNames{
    objc_setAssociatedObject(self, &associatedObjectNamesKey, associatedObjectNames,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)associatedObjectNames{
    NSMutableArray *array = objc_getAssociatedObject(self, &associatedObjectNamesKey);
    if (!array) {
        array = [NSMutableArray array];
        [self setAssociatedObjectNames:array];
    }
    return array;
}

- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy{
    objc_setAssociatedObject(self, (__bridge objc_objectptr_t)propertyName, value, policy);
    [self.associatedObjectNames addObject:propertyName];
}

- (id)objc_getAssociatedObject:(NSString *)propertyName{
    return objc_getAssociatedObject(self, (__bridge objc_objectptr_t)propertyName);
}

- (void)objc_removeAssociatedObjects{
    [self.associatedObjectNames removeAllObjects];
    objc_removeAssociatedObjects(self);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    DLog(@"setValue %@ forUndefinedKey %@",value,key);
}

- (void)setNilValueForKey:(NSString *)key{
    DLog(@"setNilValue forKey %@",key);
}

@end
