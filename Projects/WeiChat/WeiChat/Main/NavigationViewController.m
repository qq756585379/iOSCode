//
//  NavigationViewController.m
//  WeiChat
//
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

+ (void)initialize{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage gxz_imageWithColor:XZColor(43, 45, 40)]
    //                                       forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
