//
//  UIView+safe.m
//  Common
//
//  Created by 杨俊 on 2017/8/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "UIView+safe.h"
#import "NSObject+swizzle.h"

@implementation UIView (safe)

+ (void)load{
    [self exchangeMethod:@selector(setFrame:) withMethod:@selector(safeSetFrame:)];
}

- (void)safeSetFrame:(CGRect)frame{
    if (isnan(frame.origin.x)) {
        NSLog(@"%@,isnan of x",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.origin.y)) {
        NSLog(@"%@,isnan of y",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.size.width)) {
        NSLog(@"%@,isnan of w",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.size.height)) {
        NSLog(@"%@,isnan of h",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isinf(frame.origin.x)) {
        NSLog(@"%@,isinf of x",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isinf(frame.origin.y)) {
        NSLog(@"%@,isinf of y",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isinf(frame.size.width)) {
        NSLog(@"%@,isinf of w",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isinf(frame.size.height)) {
        NSLog(@"%@,isinf of h",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    [self safeSetFrame:frame];
}

@end
