//
//  MHNavigationBarMenu.h
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHNavBarMenuItem.h"

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
