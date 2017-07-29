//
//  OTSLogic.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLogic.h"

@interface OTSLogic()

@end

@implementation OTSLogic

+ (id)logicWithOperationManager:(OTSOperationManager *)aOperationManger;{
    OTSLogic *logic = [[self alloc] init];
    logic.operationManger = aOperationManger;
    logic.loading = NO;
    return logic;
}

- (void)dealloc{
    [self unobserveAllNotifications];
}

@end
