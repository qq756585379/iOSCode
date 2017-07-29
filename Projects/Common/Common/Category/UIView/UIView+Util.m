//
//  UIView+Util.m
//  MiHome
//
//  Created by yangjun on 2017/4/25.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

+ (instancetype)autolayoutView{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    //如果你定义的view想用autolayout，就将translatesAutoresizingMaskIntoConstraints设为NO
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (instancetype)viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
