//
//  UIButton+util.h
//  Common
//
//  Created by 杨俊 on 2017/6/20.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (util)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

+ (UIButton *)createButtonWithText:(NSString *)text
                         textColor:(UIColor *)txcolor
                              font:(UIFont *)font
                               tag:(NSInteger )tag
                         superView:(UIView *)superView;

@end
