//
//  PhoneNC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneNC.h"

@interface PhoneNC ()

@end

@implementation PhoneNC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)switchToRootVC:(UIViewController *)aVc{
    if (!aVc) return;
    if (self.viewControllers[0] != aVc) {
        [self setViewControllers:@[aVc]];
        if (self.topViewController.isViewLoaded) {
            [self.topViewController viewWillAppear:YES];
            [self.topViewController viewDidAppear:YES];
        }
    }
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}

#pragma mark - presentation
- (UIModalPresentationStyle)modalPresentationStyle{
    return [self.topViewController modalPresentationStyle];
}

- (UIModalTransitionStyle)modalTransitionStyle{
    return [self.topViewController modalTransitionStyle];
}

- (void)dealloc{
    [self unobserveAllNotifications];
}


@end
