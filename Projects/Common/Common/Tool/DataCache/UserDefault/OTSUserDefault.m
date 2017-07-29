//
//  OTSUserDefault.m
//  OneStoreFramework
//
//  Created by Aimy on 14-6-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSUserDefault.h"

@implementation OTSUserDefault

+ (void)setValue:(id)anObject forKey:(NSString *)aKey
{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    
    if (anObject)
    {
        [[NSUserDefaults standardUserDefaults] setObject:anObject forKey:aKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:aKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getValueForKey:(NSString *)aKey
{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)aKey {
    
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:aKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolValueForKey:(NSString *)aKey {
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:aKey];
}

@end
