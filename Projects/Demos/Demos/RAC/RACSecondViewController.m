//
//  RACSecondViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "RACSecondViewController.h"
#import "PureLayout.h"

@interface RACSecondViewController ()

@end

@implementation RACSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 30, 30)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(callBack) forControlEvents:UIControlEventTouchUpInside];
}

-(void)callBack{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:nil];
    }
}

@end
