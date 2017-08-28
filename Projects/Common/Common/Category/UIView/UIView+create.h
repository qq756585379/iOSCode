//
//  UIView+create.h
//  OneStoreFramework
//
//  Created by Aimy on 14-7-14.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

//block tool
#import <PureLayout/PureLayout.h>
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>

@interface UIView (create)

/**
 *  快捷创建UIView及其子类,backgroundcolor=[uicolor clear]
 *
 *  @param frame 大小
 *
 *  @return kind of UIView
 */
+ (instancetype)viewWithFrame:(CGRect)frame;
/**
 *  快捷创建UIView及其子类
 *
 *  @param aNibName nib名称 = self.class
 *
 *  @return kind of UIView
 */
+ (instancetype)createWithNib;
/**
 *  快捷创建UIView及其子类
 *
 *  @param aNibName nib名称
 *
 *  @return kind of UIView
 */
+ (instancetype)createWithNibName:(NSString *)aXibName;
/**
 *  快捷创建UIView
 *
 *  @param aBundleName res bundle name，NibName = self.class
 *
 *  @return OTSVC
 */
+ (instancetype)createFromNibWithBundleName:(NSString *)aBundleName NS_DEPRECATED_IOS(6_0,7_0,"Pad的资源已经合并到Application Target中，不需要从bundle中取出来，请使用不带bundle的方法");
/**
 *  快捷创建UIView及其子类
 *
 *  @param aNibName nib名称
 *  @param aBundleName bundle名称
 *
 *  @return kind of UIView
 */
+ (instancetype)createWithNibName:(NSString *)aXibName bundleName:(NSString *)aBundleName NS_DEPRECATED_IOS(6_0,7_0,"Pad的资源已经合并到Application Target中，不需要从bundle中取出来，请使用不带bundle的方法");

/**
 *  生成一个frame = CGRectZero的 View，并设置translatesAutoresizingMaskIntoConstraints = NO
 *  backgroundcolor=[uicolor clear]
 *  @return view
 */
+ (instancetype)autolayoutView;

/**
 *  完全复制一个view
 *
 *  @param view 需要复制的view
 *
 *  @return 复制的view
 */
+ (UIView *)duplicate:(UIView *)view;

/**
 *  多段落文本view
 *
 *  @param attributs 属性字典数组
 *
 *  @return 复制的view
 */
+ (UIView *)createViewWithAttriutes:(NSArray *)attributs;

@end
