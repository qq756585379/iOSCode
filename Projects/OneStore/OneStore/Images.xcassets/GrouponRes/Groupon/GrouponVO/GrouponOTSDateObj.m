//
//  OTSDateObj.m
//  GrouponProject
//
//  Created by meichun on 14-9-22.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponOTSDateObj.h"



@implementation GrouponOTSDateObj

- (BOOL)timeIsEnd
{
    if(_timeComponents == nil)
        return YES;
    NSInteger hour = _timeComponents.hour;
    NSInteger minute = _timeComponents.minute;
    NSInteger second = _timeComponents.second;
    
    if(hour + minute + second <= 0)
        return YES;
    return NO;
}

@end