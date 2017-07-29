//
//  GrouponVO.m
//  GrouponProject
//
//  Created by meichun on 14-9-22.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponVO.h"

@implementation GrouponVO

- (GrouponType)theGrouponType
{
    int grouponType = self.status.intValue;
    return (GrouponType)grouponType;
}


- (BOOL)isSerialProduct
{
    if (self.isGrouponSerial.boolValue
        || self.grouponSerials.count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isWirelessExclusivePirce
{
    if (self.channelId.integerValue == 102) {
        return YES;
    }
    return NO;
}

@end
