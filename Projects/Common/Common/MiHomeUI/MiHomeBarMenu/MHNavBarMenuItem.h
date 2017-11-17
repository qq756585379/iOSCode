//
//  MHNavBarMenuItem.h
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHNavBarMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;       // 图标
@property (nonatomic,   copy) NSString *title;        // 标题
@property (nonatomic, strong) UIColor *titleColor;  // 颜色   #4a4a4a
@property (nonatomic, strong) UIFont *titleFont;    // 字体大小

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@end
