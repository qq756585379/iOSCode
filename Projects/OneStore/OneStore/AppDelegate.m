//
//  AppDelegate.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "OTSAgreementVC.h"
#import "OTSLog.h"
#import "OTSRouter.h"
#import "OTSLaunch.h"
#import "PhoneTBC.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface AppDelegate ()<WCSessionDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //window显示之前调用
    [[OTSLaunch sharedInstance] launchBeforeShowWindow];
    
    [self initSession];
    
    //pc window
    self.pcWindow = [[OTSWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.pcWindow.backgroundColor = [UIColor clearColor];
    self.pcWindow.windowLevel = UIWindowLevelNormal + 1;
    self.pcWindow.rootViewController = [UIViewController new];
    [self.pcWindow makeKeyAndVisible];
    self.pcWindow.hidden = YES;
    //for 轮播图等促销
    self.topWindow = [[OTSWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.topWindow.backgroundColor = [UIColor clearColor];
    self.topWindow.windowLevel = UIWindowLevelAlert + 1;
    self.topWindow.rootViewController = [UIViewController new];
    [self.topWindow makeKeyAndVisible];
    self.topWindow.hidden = YES;
    
    //setup SDImageCache
    //[SDImageCache sharedImageCache].maxCacheSize  = 50 * 1024 * 1024;//50MB
    [SDImageCache sharedImageCache].maxMemoryCost = 50 * 1024 * 1024;//50MB

    [application setStatusBarHidden:NO];
    
    self.window = [[OTSWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    PhoneTBC *tbc = [PhoneTBC new];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    //setup log
    [OTSLog setupLogerStatus];
    //router
    [[OTSRouter singletonInstance] registerPCContainer:self.pcWindow.rootViewController];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    //判定系统版本。
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f) {
        [self add3Dtouch:@[@"1号海购", @"小区雷购", @"我的订单", @"我的购物车"]];
    }
#endif
    
    return YES;
}

- (void)endEditing{
	[self.window endEditing:YES];
}

#pragma mark - WCSessionDelegate & session
- (void) initSession {
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
- (void)add3Dtouch:(NSArray *)titleArray{
    NSArray *typeArray = @[@"SeaShopping", @"thunderShopping", @"myOrder", @"myShoppingCart"];
    NSArray *iconArray = @[[UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3d_haigou"],
                           [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3d_leigou"],
                           [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3d_order"],
                           [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3d_cart"],
                           ];
    NSMutableArray<UIApplicationShortcutItem *> *tempArray = [NSMutableArray array];
    for (int i = 0; i < iconArray.count; i++) {
        UIApplicationShortcutItem *tiem = [[UIApplicationShortcutItem alloc] initWithType:typeArray[i]
                                                                           localizedTitle:titleArray[i]
                                                                        localizedSubtitle:nil
                                                                                     icon:iconArray[i]
                                                                                 userInfo:nil];
        [tempArray addObject:tiem];
    }
    [UIApplication sharedApplication].shortcutItems = tempArray;
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
//    OTSBITrackerBDPramaVO *vo = [OTSBITrackerBDPramaVO new];
//    vo.w_tpa = @"1";
//    vo.w_pt = @"18000";
//    if ([shortcutItem.localizedTitle isEqualToString:@"小区雷购"]) {
//        vo.w_tpi = @"1_3";
//        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"localweb" andParams:@{@"title":@"小区雷购",@"path":@"leigou"}]]];
//    } else if ([shortcutItem.localizedTitle isEqualToString:@"我的购物车"]) {
//        vo.w_tpi = @"1_1";
//        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"cart" andParams:nil]]];
//    } else if ([shortcutItem.localizedTitle isEqualToString:@"我的订单"]) {
//        vo.w_tpi = @"1_2";
//        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"myorder" andParams:nil]]];
//    } else if ([shortcutItem.localizedTitle isEqualToString:@"1号海购"]) {
//        vo.w_tpi = @"1_4";
//        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"web" andParams:@{@"title":@"海购馆",@"url":@"http://cms.m.yhd.com/sale/120452"}]]];
//    }
//    [[OTSBITracker sharedInstance] sendTracker:nil fromPage:nil withBD:[vo convertToDictionary]];
}
#endif

@end
