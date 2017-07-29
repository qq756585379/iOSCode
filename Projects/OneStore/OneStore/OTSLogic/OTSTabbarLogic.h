//
//  OTSTabbarLogic.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLogic.h"
#import "AppTabVO.h"

@interface OTSTabbarLogic : OTSLogic

@property (nonatomic, strong) AppTabVO *appTabVO;

/**
 *  获取app的tabbar配置
 */
- (void)getAppTabWithCompletionBlock:(OTSCompletionBlock)aCompletionBlock;

@end
