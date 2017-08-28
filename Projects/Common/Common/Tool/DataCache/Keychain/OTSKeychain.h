//
//  OTSKeychain.h
//  OneStoreFramework
//
//  Created by Aimy on 14-6-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSKeychainDefine.h"

@interface OTSKeychain : NSObject

/**
 *  只能set基本数据类型,NSNumber,NSString,NSData,NSDate等,不能set继承的Class
 */
+ (void)setKeychainValue:(id<NSCopying, NSObject>)value forType:(NSString *)type;
+ (id)getKeychainValueForType:(NSString *)type;
+ (void)reset;

@end
