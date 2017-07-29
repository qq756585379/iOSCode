//
//  OTSTBC.m
//  OneStore
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSTBC.h"

@implementation OTSTBC

- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex{
    if (!aVC) {
        return ;
    }
    NSMutableArray *viewControllers = self.viewControllers.mutableCopy;
    [viewControllers replaceObjectAtIndex:aIndex withObject:aVC];
    [self setViewControllers:viewControllers animated:NO];
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return self.selectedViewController ? [self.selectedViewController shouldAutorotate] : [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.selectedViewController ?
    [self.selectedViewController supportedInterfaceOrientations] :
    [super supportedInterfaceOrientations];
}

@end
