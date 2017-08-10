//
//  OTSNC.m
//  OneStore
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSNC.h"

@interface OTSNC ()

@end

@implementation OTSNC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customAnimationDelegate = [OTSNCDelegate new];
    self.customAnimationDelegate.ownerNC = self;
    self.delegate = self.customAnimationDelegate;
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.customAnimationDelegate action:NSSelectorFromString(@"handleEdgePanGestureRecognizer:")];
    popRecognizer.delegate = self.customAnimationDelegate;
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (animated && self.customAnimationDelegate.isAppearingVC) {
        //避免同一时间push多个界面导致的crash
        return ;
    }
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 存储viewControllers
        NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.viewControllers];
        [vcArray safeAddObject:viewController];
        
        UIViewController *topViewController = self.topViewController;

        if ([topViewController isKindOfClass:[UITabBarController class]]) {
            topViewController = ((UITabBarController *)topViewController).selectedViewController;
            if ([topViewController isKindOfClass:[UINavigationController class]]) {
                topViewController = ((UINavigationController*)topViewController).topViewController;
            }
        }
        [self doBITrackerFromVC:topViewController destVC:viewController andIsPop:NO];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count > 1) {
        UIViewController *toVC = self.viewControllers[self.viewControllers.count - 2];
        [self doBITrackerFromVC:self.topViewController destVC:toVC andIsPop:YES];
    }
    // 存储viewControllers
    NSArray *vcArray = [NSArray arrayWithArray:self.viewControllers];
    vcArray = [vcArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, vcArray.count-1)]];
    
    /**
     *  nc--->tbc--->nc
     *  nc--->nc---->nc
     *  这两种结构的处理
     */
    if (self.viewControllers.count == 1) {
        if (self.tabBarController && self.tabBarController.navigationController) {
            return [self.tabBarController.navigationController popViewControllerAnimated:YES];
        }
        if (self.navigationController && self.navigationController.navigationController) {
            return [self.navigationController.navigationController popViewControllerAnimated:YES];
        }
    }
    //正常结构的处理
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger index = [self.viewControllers.copy indexOfObject:viewController];
    if (self.viewControllers.count > index + 1) {
        [self doBITrackerFromVC:self.topViewController destVC:viewController andIsPop:YES];
    }
    
    // 存储viewControllers
    NSArray *vcArray = [NSArray arrayWithArray:self.viewControllers];
    if (vcArray.count > index+1) {
        vcArray = [vcArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, index+1)]];
    }
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count > 1) {
        [self doBITrackerFromVC:self.topViewController destVC:self.viewControllers.firstObject andIsPop:YES];
    }
    // 存储viewControllers
    NSMutableArray *vcArray = [NSMutableArray new];
    [vcArray safeAddObject:self.viewControllers[0]];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - OTSTBCRepeateClickTabBarItem Delegate
- (void)repeateClickTabBarItem:(NSNumber *)count{
    if ([self.topViewController respondsToSelector:@selector(repeateClickTabBarItem:)]) {
        [self.topViewController performSelector:@selector(repeateClickTabBarItem:) withObject:count];
    }
}

- (void)doBITrackerFromVC:(UIViewController *)aFromVC destVC:(UIViewController *)aDestVC andIsPop:(BOOL)pop{
    
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}
#pragma mark - presentation
- (UIModalPresentationStyle)modalPresentationStyle{
    return [self.topViewController modalPresentationStyle];
}
- (UIModalTransitionStyle)modalTransitionStyle{
    return [self.topViewController modalTransitionStyle];
}
- (void)dealloc{
    [self unobserveAllNotifications];
}
@end














