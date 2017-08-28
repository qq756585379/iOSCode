//
//  OTSFont.h
//  OneStoreFramework
//
//  Created by Aimy on 10/5/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSFont : UIFont

+ (UIFont *)otsNumberFontOfSize:(CGFloat)fontSize;

/**
 * 小号字体
 * iPhone:10,ipad:12
 *
 *  @return
 */
+ (UIFont *)small;

/**
 *  中号字体
 * iPhone:12,ipad:14
 *  @return
 */
+ (UIFont *)medium;

/**
 *  大号字体
 * iPhone:14,ipad:16
 *  @return
 */
+ (UIFont *)large;

/**
 *  超大号字体
 * iPhone:18,ipad:20
 *  @return
 */
+ (UIFont *)bigLarge;
@end
