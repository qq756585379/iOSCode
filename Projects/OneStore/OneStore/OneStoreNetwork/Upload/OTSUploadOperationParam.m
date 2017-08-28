//
//  OTSUploadOperationParam.m
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSUploadOperationParam.h"
#import "OTSUploadFileValue.h"

@implementation OTSUploadOperationParam

#pragma mark- Property
- (NSArray *)uploadFileValues{
    if (_uploadFileValues == nil) {
        _uploadFileValues = [[NSMutableArray alloc] init];
    }
    return _uploadFileValues;
}

#pragma mark- PublicInterface
+ (instancetype)paramWithUrl:(NSString *)aUrl
                        name:(NSString *)name
                       files:(NSMutableArray *)fileValues
                       param:(NSDictionary *)aParam
                    mimeType:(EUpLoadFileMimeType)mimeType
                    callback:(OTSCompletionBlock)aCallback;{
    OTSUploadOperationParam *param = [self new];
    param.requestUrl = aUrl;
    param.requestType = kRequestPost;
    param.requestParam = aParam;
    param.callbackBlock = aCallback;
    param.uploadFileValues = fileValues;
    param.name = name;
    param.mimeType = mimeType;
    param.uploadType = kUpLoadData;
    return param;
}

+ (instancetype)paramWithUrl:(NSString *)aUrl
                    fileData:(NSData *)fileData
                        name:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(EUpLoadFileMimeType)mimeType
                    callback:(OTSCompletionBlock)aCallback
{
    OTSUploadOperationParam *param = [self new];
    param.requestUrl = aUrl;
    param.requestType = kRequestPost;
    param.requestParam = nil;
    param.callbackBlock = aCallback;
    param.name = name;
    param.mimeType = mimeType;
    param.uploadType = kUpLoadData;
    OTSUploadFileValue *fileValue = [OTSUploadFileValue fileValueData:fileData fileName:fileName];
    [param.uploadFileValues addObject:fileValue];
    return param;
}

+ (instancetype)paramWithUrl:(NSString *)aUrl
                     fileUrl:(NSURL *)fileUrl
                        name:(NSString *)name
                    callback:(OTSCompletionBlock)aCallback
{
    OTSUploadOperationParam *param = [self new];
    param.requestUrl = aUrl;
    param.requestType = kRequestPost;
    param.requestParam = nil;
    param.callbackBlock = aCallback;
    param.fileUrl = fileUrl;
    param.name = name;
    param.uploadType = kUpLoadUrl;
    return param;
}

@end
