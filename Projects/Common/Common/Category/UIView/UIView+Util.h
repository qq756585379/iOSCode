//
//  UIView+Util.h
//  MiHome
//
//  Created by yangjun on 2017/4/25.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

/**
 *  生成一个frame = CGRectZero 的 View，
 *  如果你定义的view想用autolayout，就将translatesAutoresizingMaskIntoConstraints设为NO
 */
+ (instancetype)autolayoutView;

+ (instancetype)viewFromXib;

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
