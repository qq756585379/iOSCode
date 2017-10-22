//
//  YJTabBarVC.m
//  TZTV
//
//  Created by Luosa on 2016/11/9.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "YJTabBarVC.h"
#import "YJNav.h"
#import "HomeVC.h"
#import "BrandVC.h"
#import "MeViewController.h"
#import "ShopCartVC.h"
#import "HomePageTableVC.h"
#import "YJWebViewController.h"
#import "ZhiBoListTableVC.h"
#import "FenLeiTableVC.h"
#import "HomeTableVC2.h"

@interface YJTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation YJTabBarVC

+ (void)initialize{
    UITabBar *bar=[UITabBar appearance];
    bar.barTintColor=[UIColor whiteColor];
    bar.tintColor=HEXRGBCOLOR(0x333333);
    
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = HEXRGBCOLOR(0x333333);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = YJNaviColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config0_1];
}

-(void)config0_1{
    HomePageTableVC *homePage=[[HomePageTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    ZhiBoListTableVC *zhiboVc=[[ZhiBoListTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    MeViewController *meVc=[sb instantiateViewControllerWithIdentifier:@"MeViewController"];
    YJNav *nav1=[[YJNav alloc] initWithRootViewController:homePage];
    YJNav *nav2=[[YJNav alloc] initWithRootViewController:zhiboVc];
    YJNav *nav3=[[YJNav alloc] initWithRootViewController:meVc];
    [nav1 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav2 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav3 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [self setupChildVc:nav1 title:@"首页" image:@"home" selectedImage:@"home_click"];
    [self setupChildVc:nav2 title:@"兔子秀" image:@"live" selectedImage:@"liveselected"];
    [self setupChildVc:nav3 title:@"我的" image:@"my" selectedImage:@"my_selected"];
}

-(void)config0_2{
    HomeTableVC2 *home=[[HomeTableVC2 alloc] initWithStyle:1];
    FenLeiTableVC *fenleiVc=[[FenLeiTableVC alloc] initWithStyle:UITableViewStylePlain];
    ZhiBoListTableVC *zhiboVc=[[ZhiBoListTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    ShopCartVC *shopCartVc=[sb instantiateViewControllerWithIdentifier:@"ShopCartVC"];
    MeViewController *meVc=[sb instantiateViewControllerWithIdentifier:@"MeViewController"];
    
    YJNav *nav1=[[YJNav alloc] initWithRootViewController:home];
    YJNav *nav2=[[YJNav alloc] initWithRootViewController:fenleiVc];
    YJNav *nav3=[[YJNav alloc] initWithRootViewController:zhiboVc];
    YJNav *nav4=[[YJNav alloc] initWithRootViewController:shopCartVc];
    YJNav *nav5=[[YJNav alloc] initWithRootViewController:meVc];
    
    [nav1 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav2 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav3 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav4 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    [nav5 updateNavBarBg:[UIImage imageWithColor:kWhiteColor] andShadowImage:[UIImage imageWithColor:kEDEDED]];
    
    [self setupChildVc:nav1 title:@"首页" image:@"home" selectedImage:@"home_click"];
    [self setupChildVc:nav2 title:@"品牌" image:@"brand" selectedImage:@"brand_selected"];
    [self setupChildVc:nav3 title:@"直播" image:@"live" selectedImage:@"liveselected"];
    [self setupChildVc:nav4 title:@"购物车" image:@"shopping" selectedImage:@"shopping_card_selected"];
    [self setupChildVc:nav5 title:@"我的" image:@"my" selectedImage:@"my_selected"];
}

- (void)setupChildVc:(YJNav *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.title=title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if ([item.title isEqualToString:@"发现"]) {
//        if (self.web.htmlUrl.length==0) {
//            self.web.htmlUrl=findURL;
//            [self.web loadUrl:findURL];
//        }
//    }
}

- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex{
    if (!aVC) {
        return ;
    }
    NSMutableArray *viewControllers = self.viewControllers.mutableCopy;
    [viewControllers replaceObjectAtIndex:aIndex withObject:aVC];
    [self setViewControllers:viewControllers animated:NO];
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController ? [self.selectedViewController shouldAutorotate] : [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.selectedViewController ? [self.selectedViewController supportedInterfaceOrientations] : [super supportedInterfaceOrientations];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



