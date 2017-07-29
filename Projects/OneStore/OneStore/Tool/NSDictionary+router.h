//
//  NSDictionary+router.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (router)

/**
 *  忽略key大小写查询字典
 */
- (id)objectForCaseInsensitiveKey:(NSString *)aKey;

@end
