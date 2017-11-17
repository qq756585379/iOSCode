//
//  MHTopPullMenu.h
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHNavBarMenuItem.h"

typedef void(^didSelectMenuItem)(MHNavBarMenuItem *item);

@interface MHTopPullMenu : UIView
@property (nonatomic, strong) NSArray *items;           // 菜单数据
@property (nonatomic, assign) CGFloat rowHeight;        // 菜单条目高度
@property (nonatomic, assign) BOOL showing;             //是否打开
- (void)showWithBlock:(didSelectMenuItem)aBlock;
@end
