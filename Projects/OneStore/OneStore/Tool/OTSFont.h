//
//  OTSFont.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/3.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSFont : UIFont

+ (UIFont *)otsNumberFontOfSize:(CGFloat)fontSize;

/**
 * 小号字体
 * iPhone:10,ipad:12
 */
+ (UIFont *)small;

/**
 *  中号字体
 * iPhone:12,ipad:14
 */
+ (UIFont *)medium;

/**
 *  大号字体
 * iPhone:14,ipad:16
 */
+ (UIFont *)large;

/**
 *  超大号字体
 * iPhone:18,ipad:20
 */
+ (UIFont *)bigLarge;

@end
