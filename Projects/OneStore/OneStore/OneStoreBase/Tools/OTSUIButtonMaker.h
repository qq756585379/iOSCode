//
//  OTSUIButtonMaker.h
//  OneStoreFramework
//
//  Created by airspuer on 5/1/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSViewMaker.h"

@interface OTSUIButtonMaker : OTSViewMaker

@property(nonatomic, assign)CGFloat titleFontSize;

/**
 *  UIControlStateNormal状态下的title颜色
 */
@property(nonatomic, strong)UIColor *titleColor;

/**
 *  UIControlStateNormal状态下的图片
 */
@property(nonatomic, strong)UIImage *image;

/**
 *  UIControlStateNormal状态下的背景图片
 */
@property(nonatomic, strong)UIImage *backgroundImage;

// default is UIEdgeInsetsZero
@property(nonatomic) UIEdgeInsets contentEdgeInsets;

// default is UIEdgeInsetsZero
@property(nonatomic) UIEdgeInsets imageEdgeInsets;

@property(nonatomic) UIEdgeInsets titleEdgeInsets;

/**
 *  设置button不同状态下的字体颜色，图片icon，背景图
 *
 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setImage:(UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;

@end
