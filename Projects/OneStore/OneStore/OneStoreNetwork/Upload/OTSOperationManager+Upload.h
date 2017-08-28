//
//  OTSOperationManager+Upload.h
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
//network
#import "OTSOperationManager.h"

@class OTSUploadOperationParam;

@interface OTSOperationManager (Upload)

/**
 *  上传文件
 */
- (NSURLSessionTask *)uploadWithParam:(OTSUploadOperationParam *)aParam;

@end
