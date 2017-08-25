//
//  OTSOperationManager+Batch.m
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSOperationManager+Batch.h"

@interface OTSOperationManager()
@property(nonatomic, strong) NSMutableArray *batchOperationParams;
@end

@implementation OTSOperationManager (Batch)

- (void)requestWithParams:(NSArray *)aParams andCompleteBlock:(OTSBatchCompletionBlock)completeBlock{
    WEAK_SELF;
    NSMutableArray *operations = @[].mutableCopy;
    
    [aParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        STRONG_SELF;
        if ([obj isKindOfClass:[OTSOperationParam class]]) {
            NSURLSessionDataTask *requestOperation = [self requestWithParam:obj];
            if (requestOperation) {
                [operations addObject:requestOperation];
            } else {
                [operations addObject:[NSNull null]];
            }
        }
    }];
    
    OTSBatchOperaionParam *batch = [OTSBatchOperaionParam requestWithOperationManager:self params:aParams operations:operations andCompleteBlock:^(OTSBatchOperaionParam *batchOperationParam, NSError *anError) {
        if (completeBlock) {
            completeBlock(batchOperationParam, anError);
        }
        
        if (batchOperationParam) {
            [self.batchOperationParams removeObject:batchOperationParam];
        }
    }];
    
    if (batch) {
        [self.batchOperationParams addObject:batch];
    }
}

@end
