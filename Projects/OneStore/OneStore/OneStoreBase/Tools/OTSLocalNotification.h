//
//  OTSLocalNotification.h
//  OneStore
//
//  Created by airspuer on 13-8-20.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
 UIKIT_EXTERN NSString * const OTSLocalNotificationRouterUrl;

@interface OTSLocalNotification : NSObject

/**
 *	功能:创建一个本地通知
 *
 *	@param notificationName  :通知名称,唯一的。同一名称整个app只能有一个
 *	@param notificationTitle :通知弹出出现的title
 *	@param fireDate          :通知到达时间
 *	@param routerUrl         :触发通知跳转到指定界面的url
 *  
 *      //调用例子
 *		NSMutableDictionary *routerParam = [[NSMutableDictionary alloc]init];
 *     [routerParam safeSetObject:self.theProductVO.pmId forKey:@"pmId"];
 *	   [routerParam safeSetObject:self.theProductVO.promotionId forKey:@"promotionId"];
 *		NSString *routerUrlString = [NSString getRouterVCUrlStringFromUrlString:@"productdetail" andParams:routerParam];
 *
 * 		[OTSLocalNotification createLocalNotificationWithName:kDailyBuyLocalNotificationName 
 *													withTitle:notificationTitle
 *												 withFireDate:self.theProductVO.startTime
 *                                                   routerUrl:routerUrlString];
 *
 */
+ (void)createLocalNotificationWithName:(const NSString*)notificationName
							  withTitle:(NSString*)notificationTitle
						   withFireDate:(NSDate*)fireDate
						   routerUrl:(NSString *)routerUrl;

/**
 *	功能:创建一个本地通知
 *
 *	@param	notificationName:通知名称,唯一的。同一名称整个app只能有一个
 *	@param	notificationTitle:通知弹出出现的title
 *	@param	fireDate:通知到达时间
 *  @param  userInfo:存储信息
 */
+ (void)createLocalNotificationWithName:(const NSString*)notificationName
                              withTitle:(NSString*)notificationTitle
                           withFireDate:(NSDate*)fireDate
                               userInfo:(NSDictionary*)userInfo
                              routerUrl:(NSString *)routerUrl;

/**
 *	功能:创建一个本地通知
 *
 *	@param	notificationName:通知名称,唯一的。同一名称整个app只能有一个
 *	@param	notificationTitle:通知弹出出现的title
 *	@param	fireDate:通知到达时间
 */
+ (void)createLocalNotificationWithName:(const NSString*)notificationName
                              withTitle:(NSString*)notificationTitle
                           withFireDate:(NSDate*)fireDate;

/**
 *	功能:根据通知名称查找本地通知,本地没有此通知则返回nil.
 *
 *	@param:notificationName:通知名称
 *
 *	@return:有此名称的本地通知就返回UILocalNotification的对象, 没有此通知则返回nil
 */
+ (UILocalNotification *)findLocalNotificationWithName:(const NSString*)notificationName;

/**
 *  功能:查找本地提醒中名字包含subName的提醒
 */
+ (UILocalNotification *)findLocalNotificationWithSubName:(NSString *)subName;

/**
 *	功能:根据通知触发时间查找本地通知,本地没有此通知则返回nil.
 *
 *	@param:notificationName:通知名称
 *
 *	@return:有此触发时间的本地通知就返回UILocalNotification的对象, 没有此通知则返回nil
 */
+ (UILocalNotification *)searchLocalNotificationWithTheSameFireDate:(NSDate *)date;

/**
 *	功能:是否存在此名称的本地通知
 *
 *	@param	notificationName:通知名称
 *
 *	@return:有此名称的本地通知则返回YES，反则返回NO
 */
+ (BOOL)isExistLocalNotificationWithName:(const NSString*)notificationName;

/**
 * 功能:取消此名称的本地通知
 *
 *	@param	notificationName:通知名称
 */
+ (void)cancelLocalNotificationWithName:(const NSString*)notificationName;


@end
