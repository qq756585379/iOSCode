//
//  OTSFunctionSwithLogic.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSFunctionSwithLogic.h"
#import "OTSNetworkManager.h"
#import "NSMutableDictionary+safe.h"

@implementation OTSFunctionSwithLogic

DEF_SINGLETON(OTSFunctionSwithLogic)

- (id)init{
    self = [super init];
    if (self) {
        self.operationManger = [[OTSNetworkManager sharedInstance] generateOperationMangerWithOwner:self];
    }
    return self;
}

-(AppFunctionSwitchVO *)indexBgPicTabVO{
    AppFunctionSwitchVO *indexBgPicTabVO = [self.functionSwitchDict safeObjectForKey:@"indexBgPicTab"];
    return indexBgPicTabVO;
}

@end
