//
//  OTSTabbarLogic.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSTabbarLogic.h"
#import "OTSArchiveData.h"
#import "OTSFileManager.h"

@implementation OTSTabbarLogic

+ (instancetype)logicWithOperationManager:(OTSOperationManager *)aOperationManger{
    OTSTabbarLogic *logic = [super logicWithOperationManager:aOperationManger];
    logic.appTabVO = (id)[OTSArchiveData unarchiveDataInCacheWithFileName:@"AppTabVO.plist"];
    return logic;
}

- (void)getAppTabWithCompletionBlock:(OTSCompletionBlock)aCompletionBlock{
//    WEAK_SELF;
//    OTSOperationParam *param = [OTSNITBC getAppTabWithCompletionBlock:^(id aResponseObject, NSError *anError) {
//        STRONG_SELF;
//        if ([aResponseObject isKindOfClass:[NSArray class]] && ! anError) {
//            [self storeAppTabVO:[AppTabVO voWithDict:@{@"items": aResponseObject}]];
//            
//            if (aCompletionBlock) {
//                aCompletionBlock(aResponseObject, anError);
//            }
//        }else {
//            if (aCompletionBlock) {
//                aCompletionBlock(nil, anError);
//            }
//        }
//    }];
//    [self.operationManger requestWithParam:param];
}

- (void)storeAppTabVO:(AppTabVO *)aVO{
    self.appTabVO = aVO;
    [self performInThreadBlock:^{
        NSString *documentPath = [OTSFileManager appCachePath];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"AppTabVO.plist"];
        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aVO];
        [archiveData writeToFile:filePath atomically:NO];
//        [OTSArchiveData archiveDataInCache:aVO withFileName:@"AppTabVO.plist"];
    }];
}

@end
