//
//  OTSNetworkInterface.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSNetworkInterface.h"

@implementation OTSNetworkInterface

+ (NSString *)interfaceNameFromSelector:(SEL)aSelector{
    if (aSelector){
        NSString *selStr = NSStringFromSelector(aSelector);
        NSRange range = [NSStringFromSelector(aSelector) safeRangeOfString:@":" options:NSLiteralSearch];
        if (range.location != NSNotFound){
            NSString *retStr = [selStr safeSubstringToIndex:range.location];
            return retStr;
        }
        return selStr;
    }
    return nil;
}

+ (NSError *)typeMismatchErrorWithMatchType:(Class)aMathType sourceType:(Class)aSourceType{
    NSString *errorDomain = [NSString stringWithFormat:@"TypeMismatch: matchDataType:%@, errorDataType:%@",
                             NSStringFromClass(aMathType),NSStringFromClass(aSourceType)];
    NSError *error = [NSError errorWithDomain:errorDomain
                                         code:kDataTypeMismatch
                                     userInfo:nil];
    return error;
}

@end
