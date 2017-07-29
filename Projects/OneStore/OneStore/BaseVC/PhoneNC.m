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
    // Do any additional setup after loading the view.
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
