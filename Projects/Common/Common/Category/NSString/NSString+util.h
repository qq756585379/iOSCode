//
//  NSString+util.h
//  Common
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (util)

- (NSUInteger)byteCount;
/**
 *  NSString转为NSNumber
 */
- (NSNumber *)toNumber;

- (NSString *)urlEncoding;

- (NSString *)urlDecoding;



@end
