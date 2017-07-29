//
//  PhoneApolloNC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneApolloNC.h"

@interface PhoneApolloNC ()

@end

@implementation PhoneApolloNC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)switchToRootVC:(UIViewController *)aVc{
    if (!aVc) {
        return ;
    }
    if (self.viewControllers[0] != aVc) {
        [self setViewControllers:@[aVc]];
        if (self.topViewController.isViewLoaded) {
            [self.topViewController viewWillAppear:YES];
            [self.topViewController viewDidAppear:YES];
        }
    }
}

@end
