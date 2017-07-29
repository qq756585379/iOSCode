//
//  OTSLogic.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSOperationManager.h"

@interface OTSLogic : NSObject

@property (nonatomic, strong) OTSOperationManager *operationManger;

@property (nonatomic) BOOL loading;

+ (id)logicWithOperationManager:(OTSOperationManager *)aOperationManger;

@end
