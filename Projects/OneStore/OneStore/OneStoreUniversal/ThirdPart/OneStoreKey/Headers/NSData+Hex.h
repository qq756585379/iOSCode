//
//  NSData+Hex.h
//  OneStoreFramework
//
//  Created by Vect Xi on 9/13/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hex)

/**
 *  16进制字符串转NSData
 *
 *  @param hexString
 *
 *  @return
 */
+ (NSData *)dataWithHexString:(NSString *)hexString;

/**
 *  NSData转16进制字符串
 *
 *  @return
 */
- (NSString *)hexString;

@end
