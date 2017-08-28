//
//  OTSCorner.m
//  OneStoreFramework
//
//  Created by Aimy on 9/12/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSCorner.h"

@implementation OTSCorner

+ (void)addCornerWithView:(UIView *)aView type:(UIRectCorner)aCorners size:(CGSize)aSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:aView.bounds byRoundingCorners:aCorners cornerRadii:aSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = aView.bounds;
    maskLayer.path = maskPath.CGPath;
    aView.layer.mask = maskLayer;
    aView.layer.shouldRasterize = YES;
    aView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
