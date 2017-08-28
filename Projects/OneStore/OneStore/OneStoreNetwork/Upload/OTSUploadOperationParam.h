//
//  OTSUploadOperationParam.h
//  OneStoreFramework
//
//  Created by huangjiming on 6/12/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSOperationParam.h"

@interface OTSUploadOperationParam : OTSOperationParam

@property(nonatomic, strong) NSMutableArray *uploadFileValues;     //文件数据NSArray<OTSUploadFileValue>
@property(nonatomic, strong) NSDictionary *uploadParam;
@property(nonatomic, strong) NSData *fileData;                     //文件数据
@property(nonatomic, strong) NSString *name;                       //文件key
@property(nonatomic, strong) NSString *fileName;                   //文件名
@property(nonatomic, assign) EUpLoadFileMimeType mimeType;         //文件类型
@property(nonatomic, strong) NSURL *fileUrl;                       //文件路径
@property(nonatomic, assign) EUpLoadFileType uploadType;           //上传文件方式

/**
 *	功能:初始化上传的参数。一次性上传多个同种类型的数据.默认是传文件的data
 *
 *	@param aUrl      :上传的url
 *	@param name      :上传文件名称
 *	@param mimeType  :文件类型
 *	@param aCallback :上传后的回调
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                        name:(NSString *)name
                       files:(NSMutableArray *)fileValues
                       param:(NSDictionary *)aParam
                    mimeType:(EUpLoadFileMimeType)mimeType
                    callback:(OTSCompletionBlock)aCallback;
/**
 *  data初始化方法
 *
 *  @param aUrl      目标url
 *  @param fileData  文件data
 *  @param name      key  ex:@"file1"
 *  @param fileName  文件名    ex:@"5117"
 *  @param mimeType  文件类型   ex:@"image/jpg"
 *  @param aCallback 回调
 *
 *  @return OTSUploadOperationParam
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                    fileData:(NSData *)fileData
                        name:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(EUpLoadFileMimeType)mimeType
                    callback:(OTSCompletionBlock)aCallback;

/**
 *  url初始化方法
 *
 *  @param aUrl      目标url
 *  @param fileUrl   文件本地url
 *  @param name      文件名    ex:@"5117"
 *  @param aCallback 回调
 *
 *  @return OTSUploadOperationParam
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                     fileUrl:(NSURL *)fileUrl
                        name:(NSString *)name
                    callback:(OTSCompletionBlock)aCallback;

@end

