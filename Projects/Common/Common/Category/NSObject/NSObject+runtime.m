//
//  aaa.m
//  OneStoreFramework
//
//  Created by Aimy on 14-7-20.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>

@implementation NSObject (runtime)

/**
 * 获取对象的所有属性,包括父类的。
 */
- (NSArray *)getProperties{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
	Class targetClass = [self class];
	while (targetClass != [NSObject class]) {
		objc_property_t *properties = class_copyPropertyList(targetClass, &outCount);
		for (i = 0; i < outCount; i++){
			objc_property_t property = properties[i];
			const char *char_f = property_getName(property);
			NSString *propertyName = [NSString stringWithUTF8String:char_f];
			[props addObject:propertyName];
		}
		free(properties);
		targetClass = [targetClass superclass];
	}
	return props;
}

/* 获取对象的所有方法 */
- (void)printMothList{
    unsigned int mothCout_f = 0;
    Method *mothList_f = class_copyMethodList([self class], &mothCout_f);
    for(int i = 0; i < mothCout_f; i++){
        Method temp_f = mothList_f[i];
        // IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding = method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

@end
