//
//  OTSVC.h
//  OneStore
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OTSSttusBarStyle) {
    OTSStatusBarStyleBlackFont,
    OTSStatusBarStyleWhiteFont
};

@interface OTSVC : UIViewController
/**
 *  是否能右滑返回
 */
@property (nonatomic) BOOL canDragBack;
/**
 *  是否显示导航栏的toolbar
 */
@property (nonatomic, getter=isToolbarHidden) BOOL toolbarHidden;
/**
 *  是否显示Navigation bar
 */
@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
/**
 *  导航栏背景图
 */
@property (nonatomic, copy) UIImage *navigationBarImage;
/**
 *  底部tabbar背景图
 */
@property (nonatomic, copy) UIImage *tabbarImage;
/**
 *  状态栏样式
 */
@property (nonatomic) OTSSttusBarStyle statusBarStyle;
/**
 *  title颜色
 */
@property (nonatomic, copy) UIColor *titleColor;
/**
 *  富文本title，如果设置了则title，titlecolor失效
 */
@property (nonatomic,copy) NSDictionary *titleTextAttributes;
/**
 *  显示全局消息提醒
 */
@property (nonatomic) BOOL showGlobalMessageTip;

@end
