//
//  ChatViewController.m
//  WeiChat
//+
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 237, 237);

    [self addChildViewController:self.chatBoxVC];
    [self.view addSubview:self.chatBoxVC.view];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = IColor(240, 237, 237);
    // self.view的高度有时候是不准确的
    self.tableView.frame = CGRectMake(0, HEIGHT_NAVBAR+HEIGHT_STATUSBAR, self.view.width, APP_Frame_Height-HEIGHT_TABBAR-HEIGHT_NAVBAR-HEIGHT_STATUSBAR);
}

@end
