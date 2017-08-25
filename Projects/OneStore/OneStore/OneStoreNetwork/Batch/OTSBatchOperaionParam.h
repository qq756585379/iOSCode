//
//  OTSBatchOperaionParam.h
//  OneStoreFramework
//
//  Created by Aimy on 3/25/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OTSBatchOperaionParam,OTSOperationManager;

typedef void(^OTSBatchCompletionBlock)(OTSBatchOperaionParam *batchOperationParam, NSError* anError);

@interface OTSBatchOperaionParam : NSObject

@property (strong, nonatomic, readonly) NSMutableDictionary *responseObjects;//存储的所有返回对象

@property (nonatomic, copy) OTSBatchCompletionBlock completeBlock;//完成的回调
/**
 *  创建一组调用
 */
+ (instancetype)requestWithOperationManager:(OTSOperationManager *)manager params:(NSArray *)params operations:(NSArray *)operations andCompleteBlock:(OTSBatchCompletionBlock)completeBlock;

@end
