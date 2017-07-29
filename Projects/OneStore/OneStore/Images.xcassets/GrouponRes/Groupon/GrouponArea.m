//
//  GrouponArea.m
//  GrouponProject
//
//  Created by Vect Xi on 9/29/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "GrouponArea.h"
#import "GrouponInterface.h"
#import "OTSNetworkManager.h"

@interface OTSNetworkManager()

/**
 *  功能:产生一个operation manager
 */
- (OTSOperationManager *)generateOperationManger;

@end

@interface GrouponArea ()

@property (nonatomic) BOOL provinceChanged;
@property (nonatomic) NSInteger areaId;

@property (nonatomic, strong) OTSOperationManager *operationManager;

@end

@implementation GrouponArea

DEF_SINGLETON(GrouponArea)

- (instancetype)init {
    self = [super init];
    if (self) {
        _areaId = 1;
        _provinceChanged = YES;
        
        // @TODO 注册省份切换通知监听
        [self observeNotification:OTS_PROVINCE_CHANGED];
    }
    return self;
}

- (OTSOperationManager *)operationManager {
    if (!_operationManager) {
        _operationManager = [[OTSNetworkManager sharedInstance] generateOperationManger];
    }
    return _operationManager;
}

- (void)getAreaIdWithCompletionBlock:(void (^)(NSInteger))aCompletionBlock {
    if (self.provinceChanged) {
        WEAK_SELF;
        OTSOperationParam *param
            = [GrouponInterface getAreaIdWithProvinceId:[OTSGlobalValue sharedInstance].provinceId.integerValue
                                        completionBlock:^(id aResponseObject, NSError *anError) {
                                            STRONG_SELF;
                                            
                                            if ([aResponseObject isKindOfClass:[NSNumber class]]) {
                                                self.areaId = [aResponseObject integerValue];
                                                self.provinceChanged = NO;
                                            }
                                            
                                            if (aCompletionBlock) {
                                                aCompletionBlock(self.areaId);
                                            }
                                        }];
        [self.operationManager requestWithParam:param];
    } else {
        if (aCompletionBlock) {
            aCompletionBlock(self.areaId);
        }
    }
}

- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:OTS_PROVINCE_CHANGED]) {
        self.provinceChanged = YES;
    }
}

@end
