//
//  MHGradientColorView.m
//  MHColorPicker
//
//  Created by Woody on 15/1/19.
//  Copyright (c) 2015年 小米移动软件. All rights reserved.
//

#import "MHGradientColorView.h"

@implementation MHGradientColorView

//绘制出彩色电视机那种的彩色竖条
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // draw the gradient
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    float step = 0.166666666666667f;
    CGFloat locs[7]={
        0.00f,
        step,
        step*2,
        step*3,
        step*4,
        step*5,
        1.0f
    };
    NSArray *colors=[NSArray arrayWithObjects:
                     (id)[[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0] CGColor],
                     (id)[[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
                     nil];
    CGGradientRef grad=CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width,0), CGPointMake(0, 0), kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grad);
    CGColorSpaceRelease(colorSpace);
}

@end





