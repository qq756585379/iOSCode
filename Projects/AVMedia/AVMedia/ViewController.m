//
//  ViewController.m
//  AVMedia
//
//  Created by 杨俊 on 2017/8/25.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ViewController.h"
#import "PlayAACFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Play" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonOnclick:(UIButton *)btn{
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tmp" ofType:@"aac"];
        [[[PlayAACFile alloc] init] startPlayAudio:path];
    });
}

@end
