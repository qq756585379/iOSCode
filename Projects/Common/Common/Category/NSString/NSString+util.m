//
//  NSString+util.m
//  Common
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "NSString+util.h"

@implementation NSString (util)

- (NSUInteger)byteCount{
    NSUInteger length = 0;
    char *pStr = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*pStr) {
            pStr++;
            length++;
        }else {
            pStr++;
        }
    }
    return length;
}

- (NSNumber *)toNumber{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number=[formatter numberFromString:self];
    return number;
}

- (NSString *)urlEncoding{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)urlDecoding{
    return self.stringByRemovingPercentEncoding;
}

@end
