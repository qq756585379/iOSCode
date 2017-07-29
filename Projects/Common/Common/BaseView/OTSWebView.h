//
//  OTSWebView.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/21.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSWebView : UIWebView
/**
 *  设置cookie
 */
+ (void)setCookie:(NSString *)aDomain name:(NSString *)aName value:(NSString *)aValue;
/**
 *  设置cookie
 */
+ (void)setCookieName:(NSString *)aName value:(NSString *)aValue;
/**
 *  清除cookies
 */
+ (void)clearCookies;

/**
 *  添加默认的cookies
 */
+ (void)setupDefaultCookies;

@end
