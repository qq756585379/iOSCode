//
//  UIButton+util.m
//  Common
//
//  Created by 杨俊 on 2017/6/20.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "UIButton+util.h"
#import "UIImage+Util.h"

@implementation UIButton (util)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
}

+ (UIButton *)createButtonWithText:(NSString *)text
                         textColor:(UIColor *)txcolor
                              font:(UIFont *)font
                               tag:(NSInteger )tag
                         superView:(UIView *)superView{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    if (text) [button setTitle:text forState:UIControlStateNormal];
    if (font) button.titleLabel.font=font;
    if (txcolor) {
        [button setTitleColor:txcolor forState:UIControlStateNormal];
        [button setTitleColor:txcolor forState:UIControlStateHighlighted];
    }
    if (superView) [superView addSubview:button];
    return button;
}

@end
