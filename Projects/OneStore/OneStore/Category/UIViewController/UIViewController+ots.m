//
//  UIViewController+ots.m
//  Common
//
//  Created by 杨俊 on 2017/7/26.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "UIViewController+ots.h"
#import "NSObject+category.h"
#import "OTSNetworkManager.h"

@implementation UIViewController (ots)

- (void)setOperationManager:(OTSOperationManager *)operationManager{
    if (operationManager != self.operationManager) {
        [self objc_setAssociatedObject:@"operationManager" value:operationManager policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    }
}

- (OTSOperationManager *)operationManager{
    OTSOperationManager *manager = [self objc_getAssociatedObject:@"operationManager"];
    if (manager == nil) {
        manager = [[OTSNetworkManager sharedInstance] generateOperationMangerWithOwner:self];
        [self objc_setAssociatedObject:@"operationManager" value:manager policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    }
    return manager;
}

- (void)cancelAllOperations{
    [self.operationManager cancelAllOperations];
}

- (void)repeateClickTabBarItem:(NSNumber *)count{
    DLog(@"%@ 没有实现此方法 %@",self.class, NSStringFromSelector(_cmd));
}

@end
