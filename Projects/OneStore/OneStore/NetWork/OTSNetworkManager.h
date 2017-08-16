//
//  OTSNetworkManager.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/26.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OTSOperationManager;

@interface OTSNetworkManager : NSObject

AS_SINGLETON(OTSNetworkManager)

/**
 *  功能:产生一个operation manager,当owner销毁的时候一并销毁OTSOperationManager
 */
- (OTSOperationManager *)generateOperationMangerWithOwner:(id)owner;

/**
 *  功能:移除operation manager
 */
- (void)removeOperationManger:(OTSOperationManager *)aOperationManager;

/**
 *  功能:relaunch成功后执行所有暂存的operation
 */
- (void)performAllCachedOperationsForLaunchFail;

/**
 *  功能:relaunch失败后清除所有暂存的operation
 */
- (void)clearAllCachedOperationsForLaunchFail;

@end
