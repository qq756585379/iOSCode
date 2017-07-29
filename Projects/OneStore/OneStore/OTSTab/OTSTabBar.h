//
//  OTSTabBar.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTSTabBarItem.h"

@class OTSTabBar;

@protocol OTSTabBarDelegate <NSObject>
- (void)customTabBar:(OTSTabBar *)tabBar didSelectItem:(OTSTabBarItem *)item;
@end

@interface OTSTabBar : UIView

@property (nonatomic, copy) NSArray *items;
/**
 *  背景图片
 */
@property (nonatomic, strong) UIImage *backgroundImage;
/**
 *  代理
 */
@property (nonatomic, weak) id<OTSTabBarDelegate> delegate;
/**
 *  当前选中的tabbarItem
 */
@property (nonatomic, weak) OTSTabBarItem *selectedItem;
/**
 *  当前选中的tabbarItem的序号
 */
@property (nonatomic, readonly) NSUInteger selectedIndex;

@end
