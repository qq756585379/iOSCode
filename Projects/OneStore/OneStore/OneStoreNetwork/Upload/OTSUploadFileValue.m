//
//  OTSUploadFileValue.m
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSUploadFileValue.h"

@implementation OTSUploadFileValue

/**
 *  功能:初始化方法
 */
+ (instancetype)fileValueData:(NSData *)aData fileName:(NSString *)aFileName{
    if (!aData) {
        return nil;
    }
    if (aFileName.length <= 0) {
        aFileName = @"file";
    }
    OTSUploadFileValue *fileValue = [[self alloc] init];
    fileValue.fileData = aData;
    fileValue.fileName = aFileName;
    return fileValue;
}

@end
