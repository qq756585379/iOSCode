//
//  OTSBatchOperaionParam.m
//  OneStoreFramework
//
//  Created by Aimy on 3/25/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSBatchOperaionParam.h"
#import "OTSOperationManager.h"

@interface OTSBatchOperaionParam ()
@property (strong, nonatomic) NSMutableDictionary *responseObjects;
@property (strong, nonatomic) NSArray *operations;
@property (nonatomic) NSInteger finishedCount;
@property (nonatomic) NSInteger failedCount;
@end

@implementation OTSBatchOperaionParam

+ (instancetype)requestWithOperationManager:(OTSOperationManager *)manager params:(NSArray *)params operations:(NSArray *)operations andCompleteBlock:(OTSBatchCompletionBlock)completeBlock{
    if (manager == nil || params.count == 0 || params.count != operations.count || completeBlock == nil) {
        return nil;
    }
    
    OTSBatchOperaionParam *batch = [self new];
    batch.responseObjects = @{}.mutableCopy;
    batch.operations = operations;
    batch.completeBlock = completeBlock;
    batch.finishedCount = 0;
    
    [params.copy enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OTSOperationParam *param = obj;
        OTSCompletionBlock paramCompleteBlock = nil;
        if (param.callbackBlock) {
            paramCompleteBlock = param.callbackBlock;
        }
        
        param.callbackBlock = ^(id aResponseObject, NSError *anError) {
            
            @synchronized (batch.responseObjects) { // 线程安全
                batch.responseObjects[@(idx)] = aResponseObject;
            }
            
            if (paramCompleteBlock) {
                paramCompleteBlock(aResponseObject, anError);
            }
            
            if (anError) {
                batch.failedCount++;
            } else {
                batch.finishedCount++;
            }
            
            if (batch.finishedCount + batch.failedCount == operations.count) {
                if (batch.completeBlock) {
                    batch.completeBlock(batch, anError);
                }
            }
        };
    }];
    
    return batch;
}

@end
