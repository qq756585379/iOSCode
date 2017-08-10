//
//  ViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ViewController.h"
#import "GCDTestVC.h"
#import "MHGradientColorView.h"
#import "RACViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MHGradientColorView *view = [[MHGradientColorView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.navigationController pushViewController:[GCDTestVC new] animated:YES];
    [self.navigationController pushViewController:[RACViewController new] animated:YES];
}


@end
