//
//  UIView+IB.m
//  OneStoreFramework
//
//  Created by Aimy on 5/25/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "UIView+IB.h"

@implementation UIView (IB)

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

@end
