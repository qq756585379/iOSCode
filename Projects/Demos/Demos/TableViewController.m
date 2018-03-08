//
//  TableViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/10/12.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "TableViewController.h"
#import "MHGradientColorView.h"
#import "CommonDefine.h"
#import "ZoomViewController.h"
#import "JavaScriptCoreVC.h"
#import "MHTopPullMenu.h"
#import "AVPlayerTestVC.h"
#import "TestVC.h"
#import <AudioToolbox/AudioToolbox.h>

@interface TableViewController ()
@property (nonatomic, strong) NSArray<MBExample *>*examples;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.examples = @[[MBExample exampleWithTitle:@"Indeterminate mode" selector:@"indeterminateExample"],
                      [MBExample exampleWithTitle:@"With label" selector:@"labelExample"],
                      [MBExample exampleWithTitle:@"With details label" selector:@"detailsLabelExample"],
                      [MBExample exampleWithTitle:@"Zoom View" selector:@"zoomViewExample"],
                      [MBExample exampleWithTitle:@"JavaScriptCore" selector:@"JavaScriptCore"],
                      [MBExample exampleWithTitle:@"JavaScriptCore" selector:@"JavaScriptCore"],
                      [MBExample exampleWithTitle:@"MiHome" selector:@"MiHomeUI"],
                      [MBExample exampleWithTitle:@"X" selector:@"___X"],
                      [MBExample exampleWithTitle:@"playSound" selector:@"playSound"],
                      [MBExample exampleWithTitle:@"AVPlayer" selector:@"aVPlayerExample"]
                      ];
    MHGradientColorView *view = [[MHGradientColorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = view;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MBExampleCell"];
}



-(void)zoomViewExample{
    [self.navigationController pushViewController:[ZoomViewController new] animated:YES];
}

#pragma mark - 视频播放器demo
-(void)aVPlayerExample{
    [self.navigationController pushViewController:[AVPlayerTestVC new] animated:YES];
}

-(void)JavaScriptCore{
    [self.navigationController pushViewController:[JavaScriptCoreVC new] animated:YES];
}

-(void)MiHomeUI{
//    MHTopPullMenu *menu = [[MHTopPullMenu alloc] init];
//    menu.rowHeight = 50.0f;
//    MHNavBarMenuItem *item1 = [[MHNavBarMenuItem alloc] initWithImage:nil title:@"开关"];
//    MHNavBarMenuItem *item2 = [[MHNavBarMenuItem alloc] initWithImage:nil title:@"开关"];
//    MHNavBarMenuItem *item3 = [[MHNavBarMenuItem alloc] initWithImage:nil title:@"开关"];
//    menu.items = @[item1, item2, item3];
//    [menu setDidSelectMenuItem:^(MHTopPullMenu *menu, MHNavBarMenuItem *item) {
//
//    }];
//    [menu show];
}

-(void)___X{
    [self.navigationController pushViewController:[TestVC new] animated:YES];
}

-(void)playSound{
    //通过NSBundle来获得音频文件的url地址
//    NSURL *url = [[NSBundle mainBundle] URLForResource:s withExtension:@"wav"];
//    SystemSoundID winSound;//整形类型的id
//    //用音频服务，为音频文件绑定soundID
//    AudioServicesCreateSystemSoundID((CFURLRef)url, &winSound);
//    //通过绑定的soundId来播放音乐
//    AudioServicesPlayAlertSound(winSound);
}

@end
