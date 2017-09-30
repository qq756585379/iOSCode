//
//  ShaderViewController.m
//  OpenGL
//
//  Created by 杨俊 on 2017/7/7.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ShaderViewController.h"
#import "LearnView.h"

@interface ShaderViewController ()
@property (nonatomic , strong) LearnView *myView;
@end

@implementation ShaderViewController

- (void)loadView {
    self.view = [[LearnView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myView = (LearnView *)self.view;
}

@end
