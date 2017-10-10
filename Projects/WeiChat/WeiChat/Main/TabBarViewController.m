//
//  TabBarViewController.m
//  WeiChat
//
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "TabBarViewController.h"
#import "ColorDefine.h"
#import "NavigationViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:9 / 255.0 green:187 / 255.0 blue:7 / 255.0 alpha:1];
    
    MessageViewController *messageVc = [[MessageViewController alloc] init];
    [self addChildVc:messageVc title:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    
    ContactViewController *contactsVc = [[ContactViewController alloc] init];
    [self addChildVc:contactsVc title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    
    DiscoverViewController *applicationVc = [[DiscoverViewController alloc] init];
    [self addChildVc:applicationVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    
    MineViewController *mineVc = [[MineViewController alloc] init];
    [self addChildVc:mineVc title:@"我" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGB(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = RGB(26, 178, 10);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
