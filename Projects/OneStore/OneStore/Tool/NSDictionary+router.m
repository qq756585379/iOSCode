//
//  NSDictionary+router.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "NSDictionary+router.h"

@implementation NSDictionary (router)

- (id)objectForCaseInsensitiveKey:(NSString *)aKey{
    if (!aKey) {
        return nil;
    }
    __block id returnObj = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *tempKey = key;
        if ([tempKey compare:aKey options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            returnObj = obj;
            *stop = YES;
        }
    }];
    return returnObj;
}

@end
