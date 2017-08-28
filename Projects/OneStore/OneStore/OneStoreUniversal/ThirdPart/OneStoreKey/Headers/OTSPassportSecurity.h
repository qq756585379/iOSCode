//
//  OTSPassportSecurity.h
//  OneStoreMain
//
//  Created by Vect Xi on 11/24/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSPassportSecurity : NSObject

/**
 *  RSA加密
 *
 *  @param plainText
 *
 *  @return 
 */
+ (NSString *)rsaEncryptString:(NSString *)plainText;

@end
