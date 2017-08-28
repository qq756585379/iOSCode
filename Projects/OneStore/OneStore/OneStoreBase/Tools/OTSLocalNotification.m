//
//  OTSLocalNotification.m
//  OneStore
//
//  Created by airspuer on 13-8-20.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "OTSLocalNotification.h"
#import "NSMutableDictionary+safe.h"
#import "NSArray+safe.h"

NSString *const OTSLocalNotificationRouterUrl = @"routerUrl";
const NSString* OTSLocalNotificationValue = @"OTSLocalNotificationValue";


@implementation OTSLocalNotification

+ (void)createLocalNotificationWithName:(const NSString*)notificationName
                              withTitle:(NSString*)notificationTitle
                           withFireDate:(NSDate*)fireDate
                               userInfo:(NSDictionary*)userInfo
                              routerUrl:(NSString *)routerUrl
{
    if (notificationName.length <= 0) {
        return;
    }
    //没有过期时间则不创建
    if (!fireDate) {
        return;
    }
    //创建非重复的通知
    if ([self isExistLocalNotificationWithName:notificationName]) {
        return;
    }
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = notificationTitle;
    localNotification.fireDate = fireDate;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置按钮
    localNotification.alertAction = @"关闭";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict safeSetObject:OTSLocalNotificationValue forKey:notificationName];
    [dict safeSetObject:routerUrl forKey:OTSLocalNotificationRouterUrl];
    if (userInfo != nil) {
        [dict addEntriesFromDictionary:userInfo];
    }
    [localNotification setUserInfo:dict];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


+ (void)createLocalNotificationWithName:(const NSString*)notificationName
							  withTitle:(NSString*)notificationTitle
						   withFireDate:(NSDate*)fireDate
						   routerUrl:(NSString *)routerUrl
{
    [self createLocalNotificationWithName:notificationName withTitle:notificationTitle withFireDate:fireDate userInfo:nil routerUrl:routerUrl];
}

+ (void)createLocalNotificationWithName:(const NSString*)notificationName
                              withTitle:(NSString*)notificationTitle
                           withFireDate:(NSDate*)fireDate
{
	[self createLocalNotificationWithName:notificationName withTitle:notificationTitle withFireDate:fireDate routerUrl:nil];
}

+ (UILocalNotification *)findLocalNotificationWithName:(const NSString*)notificationName
{
    if (notificationName.length <= 0) {
        return nil;
    }
    
    UILocalNotification* resultLocalNotification = nil;
    NSArray *localNotificationArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification* localNotification in localNotificationArray){
        NSDictionary* notificationUserInfo = localNotification.userInfo;
        NSString* notificationValue = [notificationUserInfo objectForKey:notificationName];
        if([notificationValue isEqualToString:(NSString*)OTSLocalNotificationValue]){
            resultLocalNotification = localNotification;
            //NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //NSLog(@"fireDate:%@",[formatter stringFromDate:resultLocalNotification.fireDate]);
            break;
        }
    }
    return resultLocalNotification;
}

/**
 *  功能:查找本地提醒中名字包含subName的提醒
 */
+ (UILocalNotification *)findLocalNotificationWithSubName:(NSString *)subName
{
    if (subName.length <= 0) {
        return nil;
    }
    
    UILocalNotification *resultLocalNotification = nil;
    NSArray *localNotificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *localNotification in localNotificationArray) {
        NSDictionary *notificationUserInfo = localNotification.userInfo;
        NSString *notificationName = [notificationUserInfo.allKeys safeObjectAtIndex:0];
        if (notificationName.length>0 && [notificationName rangeOfString:subName].location != NSNotFound) {
            resultLocalNotification = localNotification;
            break;
        }
    }
    return resultLocalNotification;
}

+ (UILocalNotification *)searchLocalNotificationWithTheSameFireDate:(NSDate *)date {
    if (date == nil) {
        return nil;
    }
    
    UILocalNotification* resultLocalNotification = nil;
    NSArray *localNotificationArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification* localNotification in localNotificationArray){
        if([localNotification.fireDate isEqualToDate:date]){
            resultLocalNotification = localNotification;
            
            break;
        }
    }
    
    return resultLocalNotification;
}

+ (BOOL)isExistLocalNotificationWithName:(const NSString*)notificationName
{
    if (notificationName.length <= 0) {
        return NO;
    }
    UILocalNotification* resultLocalNotification =  [self findLocalNotificationWithName:notificationName];
    return (resultLocalNotification != nil);
}


+ (void)cancelLocalNotificationWithName:(const NSString*)notificationName
{
    if (notificationName.length <= 0) {
        return;
    }
    UILocalNotification* resultLocalNotification =  [self findLocalNotificationWithName:notificationName];
    if(resultLocalNotification){
        [[UIApplication sharedApplication] cancelLocalNotification:resultLocalNotification];
    }
}

@end
