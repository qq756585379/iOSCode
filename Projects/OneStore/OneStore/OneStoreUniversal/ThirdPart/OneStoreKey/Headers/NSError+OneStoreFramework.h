//
//  NSError+OneStoreFramework.h
//  OneStoreFramework
//
//  Created by Vect Xi on 9/13/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const OTSFrameworkErrorDomain;

@interface NSError (OneStoreFramework)

+ (NSError *)frameworkErrorWithMessage:(NSString *)errorMessage;

@end
