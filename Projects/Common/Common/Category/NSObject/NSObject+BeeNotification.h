//
//  NSObject+BeeNotification.h
//  Common
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BeeNotification)
/**
 *  处理处理通知
 */
- (void)handleNotification:(NSNotification *)notification;
/**
 *  注册通知
 *
 *  @param name 通知名称
 */
- (void)observeNotification:(NSString *)name;
/**
 *  取消注册通知
 *
 *  @param name 通知名称
 */
- (void)unobserveNotification:(NSString *)name;
/**
 *  取消注册的所有通知
 */
- (void)unobserveAllNotifications;
/**
 *  发送通知
 *
 *  @param name 通知名称
 */
- (void)postNotification:(NSString *)name;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object 传递的参数
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object 传递的参数
 *  @param info 传递的参数
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object userInfo:(NSDictionary *)info;

@end






