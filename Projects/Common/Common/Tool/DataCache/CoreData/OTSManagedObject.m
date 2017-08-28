//
//  OTSManagedObject.m
//  OneStoreFramework
//
//  Created by huang jiming on 14-8-7.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSManagedObject.h"
#import "OTSCoreDataManager.h"
//category
#import "NSObject+BeeNotification.h"

@implementation OTSManagedObject

- (void)dealloc{
    [self unobserveAllNotifications];
}

@end
