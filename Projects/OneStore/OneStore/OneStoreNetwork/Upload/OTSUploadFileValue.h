//
//  OTSUploadFileValue.h
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSUploadFileValue : NSObject

@property(nonatomic, strong) NSData *fileData; //文件数据
@property(nonatomic, strong) NSString *fileName;

/**
 *  功能:初始化方法
 */
+ (instancetype)fileValueData:(NSData *)aData fileName:(NSString *)aFileName;

@end
