//
//  RACViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "RACViewController.h"
#import "RACSecondViewController.h"

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 30, 30)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(tosubvc) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tosubvc{
    RACSecondViewController *twoVc = [[RACSecondViewController alloc] init];
    twoVc.delegateSignal = [RACSubject subject];
    // 订阅代理信号
    [twoVc.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮");
    }];
    
    [[twoVc rac_signalForSelector:@selector(callBack)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];
    
    [self.navigationController pushViewController:twoVc animated:YES];
}

@end
