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

@end














