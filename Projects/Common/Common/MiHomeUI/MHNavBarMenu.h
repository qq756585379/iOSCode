//
//  MHNavBarMenu.h
//  MiHome
//
//  Created by CoolKernel on 7/17/16.
//  Copyright © 2016 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHNavBarMenuItem : NSObject
@property (nonatomic, strong) UIImage *image;       // 图标
@property (nonatomic,   copy) NSString *title;        // 标题
@property (nonatomic, strong) UIColor *titleColor;  // 颜色   #4a4a4a
@property (nonatomic, strong) UIFont *titleFont;    // 字体大小
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
@end

@interface MHNavigationBarMenu : NSObject
@property (nonatomic, strong) NSArray *items;           // 菜单数据
@property (nonatomic, assign) CGRect triangleFrame;     // 三角形位置 default : CGRectMake(width-33, 0, 12, 12)
@property (nonatomic, strong) UIColor *separatorColor;  // 分割线颜色 #e8e8e8
@property (nonatomic, assign) CGFloat rowHeight;        // 菜单条目高度
@property (nonatomic, copy) void(^didSelectMenuItem)(MHNavigationBarMenu *menu, MHNavBarMenuItem *item);// 点击条目
- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width;
- (void)show;
- (void)dismiss;
@end

@interface MHTopPullMenu : NSObject
@property (nonatomic, strong) NSArray *items;           // 菜单数据
@property (nonatomic, assign) CGFloat rowHeight;        // 菜单条目高度
@property (nonatomic, assign) BOOL showing;             //是否打开
@property (nonatomic,   copy) void(^didSelectMenuItem)(MHTopPullMenu *menu, MHNavBarMenuItem *item);// 点击条目
- (instancetype)initWithMenu;
- (void)show;
- (void)dismiss;
@end

@interface MHBottomTipMenu : NSObject
@property (nonatomic, strong) NSArray *items;           // 菜单数据
@property (nonatomic, assign) CGFloat rowHeight;        // 菜单条目高度
@property (nonatomic, assign) BOOL showing;             //是否打开
@property (nonatomic, strong) MHNavBarMenuItem *selectedItem;
@property (nonatomic,   copy) void(^didSelectMenuItem)(MHBottomTipMenu *menu, MHNavBarMenuItem *item);// 点击条目
- (instancetype)initWithMenu;
- (void)show;
- (void)dismiss;
@end

