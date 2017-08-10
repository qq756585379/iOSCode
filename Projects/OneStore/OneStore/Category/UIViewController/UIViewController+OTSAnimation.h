//
//  UIViewController+OTSAnimation.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (OTSAnimation)

//navigation
- (id<UIViewControllerAnimatedTransitioning>)pushAnimations;
- (id<UIViewControllerAnimatedTransitioning>)popAnimations;
- (id<UIViewControllerAnimatedTransitioning>)pushInteractions;
- (id<UIViewControllerAnimatedTransitioning>)popInteractions;

@end
