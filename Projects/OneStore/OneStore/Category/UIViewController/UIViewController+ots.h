//
//  UIViewController+ots.h
//  Common
//
//  Created by 杨俊 on 2017/7/26.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTSOperationManager.h"

@interface UIViewController (ots)
/**
 *  网络管理
 */
@property (nonatomic, strong, readwrite) OTSOperationManager *operationManager;

- (void)cancelAllOperations;

/**
 *  OTSVC如果需要响应tabbarItem被多次点击的提示，请overwrite实现这个方法
 */
- (void)repeateClickTabBarItem:(NSNumber *)count;

@end
