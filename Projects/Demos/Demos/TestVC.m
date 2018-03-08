//
//  TestVC.m
//  Demos
//
//  Created by 杨俊 on 2017/11/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "TestVC.h"
#import "LogDefine.h"

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;//使用autolayout
    
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *left = [contentView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor];
        NSLayoutConstraint *right = [contentView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor];
        NSLayoutConstraint *top = [contentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:-60];
        NSLayoutConstraint *height = [contentView.heightAnchor constraintEqualToConstant:300];
        [NSLayoutConstraint activateConstraints:@[left, right, top, height]];
    }else{
        NSLayoutConstraint *left = [contentView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [contentView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        NSLayoutConstraint *top = [contentView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
        NSLayoutConstraint *height = [contentView.heightAnchor constraintEqualToConstant:300];
        [NSLayoutConstraint activateConstraints:@[left, right, top, height]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (@available(iOS 11.0, *)) {
        NSLog(@"%f--%f",self.view.safeAreaInsets.top,self.view.safeAreaInsets.bottom);//88.000000--34.000000
        PrintRect(self.view.safeAreaLayoutGuide.layoutFrame);// NSRect: {{0, 0}, {375, 690}}
    } else {
        
    }
}

//约束

/*
 iphone x   ios11
 NSLog(@"%f--%f",self.view.safeAreaInsets.top,self.view.safeAreaInsets.bottom);//88.000000--34.000000
 PrintRect(self.view.safeAreaLayoutGuide.layoutFrame);// NSRect: {{0, 0}, {375, 690}}
 */

/*
 iphone 8   ios11
 NSLog(@"%f--%f",self.view.safeAreaInsets.top,self.view.safeAreaInsets.bottom);//64.000000--0.000000
 PrintRect(self.view.safeAreaLayoutGuide.layoutFrame);// NSRect: {{0, 0}, {375, 603}}
 */


@end
