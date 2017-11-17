//
//  MHBottomTipMenu.h
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHNavBarMenuItem.h"

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
