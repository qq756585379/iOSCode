//
//  OTSOperationManager+Batch.h
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
//network
#import "OTSOperationManager.h"
#import "OTSBatchOperaionParam.h"

@interface OTSOperationManager (Batch)

/**
 *  功能:发送一组请求
 *  aParams ＝ list of OTSOperationParam
 */
- (void)requestWithParams:(NSArray *)aParams andCompleteBlock:(OTSBatchCompletionBlock)completeBlock;

@end
