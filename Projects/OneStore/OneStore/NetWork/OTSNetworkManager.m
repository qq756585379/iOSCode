//
//  OTSNetworkManager.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/26.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSNetworkManager.h"
#import "OTSOperationManager.h"

@interface OTSNetworkManager()
@property(nonatomic, strong) NSMutableArray *operationManagers;
@end

@implementation OTSNetworkManager

DEF_SINGLETON(OTSNetworkManager)

/**
 *  功能:产生一个operation manager,当owner销毁的时候一并销毁OTSOperationManager
 */
- (OTSOperationManager *)generateOperationMangerWithOwner:(id)owner{
    OTSOperationManager *operationManager = [OTSOperationManager managerWithOwner:owner];
    if (operationManager) {
        [self.operationManagers addObject:operationManager];
    }
    return operationManager;
}

/**
 *  功能:移除operation manager
 */
- (void)removeOperationManger:(OTSOperationManager *)aOperationManager{
    
}

- (NSMutableArray *)operationManagers{
    if (_operationManagers == nil) {
        _operationManagers = [NSMutableArray array];
    }
    return _operationManagers;
}

@end
