//
//  PhoneTBC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneTBC.h"
#import "OTSTabBar.h"
#import "PhoneApolloNC.h"
#import "PhoneVC.h"
#import "PhoneCustomRootNC.h"
#import "PhoneCartNC.h"
#import "OTSTabbarLogic.h"
#import "OTSArchiveData.h"
#import "UIViewController+ots.h"
#import "AppFunctionSwitchVO.h"
#import "OTSFunctionSwithLogic.h"

@interface PhoneTBC ()<OTSTabBarDelegate>
@property (nonatomic, strong) OTSTabBar *customTabBar;
@property (nonatomic, assign) NSUInteger lastSelectedIndex;
@property (nonatomic, strong) OTSTabbarLogic *logic;
@end

@implementation PhoneTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self observeNotification:OTS_HOMEPAGE_ACTIVITY];
    [self observeNotification:OTS_HOMEPAGE_TABBAR_ITEM];
    [self _PhoneTBC_setup];
    [self _PhoneTBC_setupVCs];
    [self _PhoneTBC_setupViews];
    
    [self updateWithVO:self.logic.appTabVO.items];
    
    WEAK_SELF;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"updateTabVO" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        STRONG_SELF;
        PhoneTabBarItem *item = note.object;
        AppTabVO *newVO = [AppTabVO new];
        NSMutableArray *items = self.logic.appTabVO.items.mutableCopy;
        NSInteger index = [self.customTabBar.items indexOfObject:item];
        if (items.count >= index + 1) {
            [items replaceObjectAtIndex:[self.customTabBar.items indexOfObject:item] withObject:item.vo];
        }
        newVO.items = (id)items;

        [OTSArchiveData archiveDataInCache:newVO withFileName:@"AppTabVO.plist"];
        self.logic.appTabVO = newVO;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        STRONG_SELF;
        [self getCustomTabBar];
    }];
}
    
- (void)updateWithVO:(NSArray *)itemsArray{
    
}

- (void)_PhoneTBC_setup{
    self.delegate = self;
    [[OTSRouter singletonInstance] registerRootVC:self];
    [[OTSRouter singletonInstance] registerTabArray:@[@"home", @"category", @"", @"cart", @"mystore"]];
}

- (void)_PhoneTBC_setupVCs{
    PhoneApolloNC *nc1 = [PhoneApolloNC new];
    
    PhoneVC *vc2 = [NSClassFromString(@"PhoneCategoryVC") new];
    PhoneNC *nc2 = [[PhoneNC alloc] initWithRootViewController:vc2];
    
    //    PhoneVC *vc3 = [NSClassFromString(@"PhoneDailyDealsVC") new];
    //    PhoneCustomRootNC *nc3 = [[PhoneCustomRootNC alloc] initWithRootViewController:vc3];
    
    PhoneVC *vc3 = [NSClassFromString(@"OTSWebVC") new];
    PhoneCustomRootNC *tempNC3 = [[PhoneCustomRootNC alloc] initWithRootViewController:vc3];
    PhoneCustomRootNC *nc3 = [tempNC3 createWithUrlString:@"yhd://localweb/?body={\"path\":\"yipintang\",\"fullScreen\":0}"];
    
    PhoneVC *vc4 = [NSClassFromString(@"OTSCartVC") new];
    PhoneCartNC *nc4 = [[PhoneCartNC alloc] initWithRootViewController:vc4];
    
    PhoneVC *vc5 = [NSClassFromString(@"PhoneMyyhdIndexTVC") new];
    PhoneNC *nc5 = [[PhoneNC alloc] initWithRootViewController:vc5];
    
    [self setViewControllers:@[nc1, nc2, nc3, nc4, nc5] animated:NO];
}

- (void)_PhoneTBC_setupViews{
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.tabBar.itemWidth = 0;
    
    self.customTabBar = [[OTSTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    self.customTabBar.backgroundColor = [UIColor whiteColor];
    self.customTabBar.delegate = self;
    
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self.tabBar addSubview:self.customTabBar];
    
    PhoneTabBarItemVO *homeItemVO = [PhoneTabBarItemVO new];
    homeItemVO.title = @"首页";
    homeItemVO.image = [UIImage imageNamed:@"tabbar_homepage"];
    homeItemVO.selectedImage = [UIImage imageNamed:@"tabbar_homepage_sel"];
    homeItemVO.hostString = @"home";
    homeItemVO.showWord = YES;
    
    PhoneTabBarItemVO *categoryItemVO = [PhoneTabBarItemVO new];
    categoryItemVO.title = @"分类";
    categoryItemVO.image = [UIImage imageNamed:@"tabbar_category"];
    categoryItemVO.selectedImage = [UIImage imageNamed:@"tabbar_category_sel"];
    categoryItemVO.hostString = @"category";
    categoryItemVO.showWord = YES;
    
    PhoneTabBarItemVO *customItemVO = [PhoneTabBarItemVO new];
    customItemVO.title = @"一品堂";
    customItemVO.image = [UIImage imageNamed:@"tabbar_dailybuy"];
    customItemVO.selectedImage = [UIImage imageNamed:@"tabbar_dailybuy_sel"];
    customItemVO.hostString = @"dailybuy";
    customItemVO.showWord = YES;
    
    PhoneTabBarItemVO *cartItemVO = [PhoneTabBarItemVO new];
    cartItemVO.title = @"购物车";
    cartItemVO.image = [UIImage imageNamed:@"tabbar_cart"];
    cartItemVO.selectedImage = [UIImage imageNamed:@"tabbar_cart_sel"];
    cartItemVO.hostString = @"cart";
    cartItemVO.showWord = YES;
    
    PhoneTabBarItemVO *myaccountItemVO = [PhoneTabBarItemVO new];
    myaccountItemVO.title = @"我的1号店";
    myaccountItemVO.image = [UIImage imageNamed:@"tabbar_myaccount"];
    myaccountItemVO.selectedImage = [UIImage imageNamed:@"tabbar_myaccount_sel"];
    myaccountItemVO.hostString = @"mystore";
    myaccountItemVO.showWord = YES;
    
    NSArray *vos = @[homeItemVO, categoryItemVO, customItemVO, cartItemVO, myaccountItemVO];
    
    NSMutableArray *items = @[].mutableCopy;
    
    WEAK_SELF;
    [vos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        STRONG_SELF;
        PhoneTabBarItem *item = [PhoneTabBarItem new];
        item.defaultVO = obj;
        [items addObject:item];
        [self.viewControllers[idx] setTabbarItem:item];
    }];
    self.customTabBar.items = items.copy;
}

- (void)getCustomTabBar{
    WEAK_SELF;
    [self.logic getAppTabWithCompletionBlock:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSArray class]]) {
            STRONG_SELF;
            [self updateWithVO:self.logic.appTabVO.items];
        }
    }];
}

#pragma mark - OTSTBCDelegate
- (void)customTabBar:(OTSTabBar *)tabBar didSelectItem:(OTSTabBarItem *)item{
    BOOL needSendTrack = NO;
    NSInteger currentPageIndex = self.selectedIndex;
    NSInteger willSelectPageIndex = [tabBar.items indexOfObject:item];
    if (currentPageIndex != willSelectPageIndex) {
        needSendTrack = YES;
    }
    //last index现在只能用于从购物车返回，还不能用于其他地方
    if (self.selectedIndex != 3 && self.selectedIndex != 2) {
        self.lastSelectedIndex = self.selectedIndex;
    }
    self.customTabBar.selectedItem = item;
    item.showIndicate = NO;
    PhoneTabBarItem *tempItem = (PhoneTabBarItem *)item;
    if (tempItem.vo.type.integerValue > 0 && tempItem.vo.redPoint.boolValue) {
        NSDate *nowDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:@((nowDate.timeIntervalSince1970) * 1000) forKey:[NSString stringWithFormat:@"PhoneTabBarItemLastUpdateTime%@",tempItem.vo.type]];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    [super setSelectedIndex:self.customTabBar.selectedIndex];
    
    if (self.customTabBar.selectedIndex == 0) {
        [self dealBackgroundImage];
    } else {
        self.customTabBar.backgroundImage = nil;
    }
    
    //custom tabbar
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (id)self.selectedViewController;
        UIViewController *vc = nc.topViewController;
        self.tabBar.hidden = vc.hidesBottomBarWhenPushed;
    }
    
    static NSInteger count = 0;
    if (self.selectedIndex != self.lastSelectedIndex) {
        count = 0;
    }else {
        count++;
    }
    
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = [(UINavigationController *)self.selectedViewController topViewController];
        [vc repeateClickTabBarItem:@(count)];
    }
    
    if (needSendTrack) {
        OTSVC *afromVc = nil;
        UIViewController *vc = self.viewControllers[currentPageIndex];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (id)vc;
            afromVc = (id)nc.topViewController;
        }
        
        OTSVC *aDestVC = nil;
        vc = self.selectedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (id)vc;
            aDestVC = (id)nc.topViewController;
        }
        
        [self doBITrackerFromVC:afromVc destVC:aDestVC destIndex:self.selectedIndex];
    }
}

-(void)dealBackgroundImage{
    AppFunctionSwitchVO *indexBgPicTabVO = [[OTSFunctionSwithLogic sharedInstance] indexBgPicTabVO];
    if (indexBgPicTabVO && indexBgPicTabVO.functionSwitch.boolValue) {
        WEAK_SELF;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:indexBgPicTabVO.functionValue] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            STRONG_SELF;
            if (!error && finished) {
                self.customTabBar.backgroundImage = image;
            }
        }];
    }
}

-(void)handleNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:OTS_HOMEPAGE_ACTIVITY]) {
        [self dealBackgroundImage];
    } else if ([notification.name isEqualToString:OTS_HOMEPAGE_TABBAR_ITEM]){
        if ([notification.object isKindOfClass:[NSArray class]]) {
            self.logic.appTabVO.items = notification.object;
            [self updateWithVO:notification.object];
        }
    }
}

- (OTSTabbarLogic *)logic{
    if (!_logic) {
        _logic = [OTSTabbarLogic logicWithOperationManager:self.operationManager];
    }
    return _logic;
}

@end
