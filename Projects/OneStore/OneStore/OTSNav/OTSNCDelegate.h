//
//  OTSNCDelegate.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSNCDelegate : NSObject <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic,   weak) UINavigationController *ownerNC;

@property (nonatomic, getter=isAppearingVC) BOOL appearingVC;

@end
