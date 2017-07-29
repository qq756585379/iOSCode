//
//  GrouponViewVO.m
//  GrouponProject
//
//  Created by meichun on 14-9-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponViewVO.h"
#import "NSObject+coder.h"
#import "NSDate+OTS.h"

@implementation GrouponViewVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self otsEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self otsDecodeWithCoder:aDecoder];
}

- (NSMutableDictionary *)activityByDate
{
    if (self.containers.count <= 0) {
        return nil;
    }
    
    NSString *todayStr = [[NSDate date] dateString];
    NSMutableDictionary *activityByDate = [NSMutableDictionary dictionaryWithCapacity:0];
    
    //按日期分组
    for (GrouponContainerVO *containerVO in self.containers) {
        NSString *dayStr = [containerVO.startTime safeSubstringWithRange:NSMakeRange(0, 10)];
        if (dayStr == nil) {
            dayStr = [todayStr mutableCopy];
        }
        
        NSMutableArray *activityInOneDay = [activityByDate safeObjectForKey:dayStr];
        if (activityInOneDay == nil) {
            activityInOneDay = [NSMutableArray arrayWithCapacity:0];
            [activityByDate safeSetObject:activityInOneDay forKey:dayStr];
        }
        [activityInOneDay safeAddObject:containerVO];
        
        //记录viewId TODO
//        containerVO.viewId = self.nid;
    }
    
    //最多显示3天数据
    NSMutableArray *allKeys = [NSMutableArray arrayWithArray:activityByDate.allKeys];
    [allKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSUInteger startIndex = 0;
    NSUInteger indexOfToday = [allKeys indexOfObject:todayStr];
    if (indexOfToday == NSNotFound) {
        startIndex = 0;
    } else if (indexOfToday + 3 < allKeys.count) {
        startIndex = indexOfToday;
    } else if (allKeys.count <= 3) {
        startIndex = 0;
    } else {
        startIndex = allKeys.count - 3;
    }
    
    NSMutableDictionary *newActivity = [NSMutableDictionary dictionaryWithCapacity:0];
    NSInteger i;
    for (i=startIndex; i<allKeys.count; i++) {
        NSString *key = [allKeys safeObjectAtIndex:i];
        NSMutableArray *object = [activityByDate safeObjectForKey:key];
        //当天的活动按开始时间排序
        [object sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 isKindOfClass:[GrouponContainerVO class]] && [obj2 isKindOfClass:[GrouponContainerVO class]]) {
                NSString *startTime1 = [(GrouponContainerVO*)obj1 startTime];
                NSString *startTime2 = [(GrouponContainerVO*)obj2 startTime];
                return [startTime1 compare:startTime2];
            } else {
                return [obj1 compare:obj2];
            }
        }];
        [newActivity safeSetObject:object forKey:key];
    }
    
    return newActivity;
}

@end
