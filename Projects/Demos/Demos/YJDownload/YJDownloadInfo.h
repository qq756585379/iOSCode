//
//  YJDownloadInfo.h
//  Demos
//
//  Created by 杨俊 on 2017/11/3.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJDownload.h"

@interface YJDownloadInfo : NSObject
/** 下载状态 */
@property (assign, nonatomic, readonly) YJDownloadState state;
/** 这次写入的数量 */
@property (assign, nonatomic, readonly) NSInteger bytesWritten;
/** 已下载的数量 */
@property (assign, nonatomic, readonly) NSInteger totalBytesWritten;
/** 文件的总大小 */
@property (assign, nonatomic, readonly) NSInteger totalBytesExpectedToWrite;
/** 文件名 */
@property (copy, nonatomic) NSString *filename;
/** 文件路径 */
@property (copy, nonatomic) NSString *file;
/** 文件url */
@property (copy, nonatomic) NSString *url;
/** 下载的错误信息 */
@property (strong, nonatomic, readonly) NSError *error;
/** 存放所有的进度回调 */
@property (copy, nonatomic) MJDownloadProgressChangeBlock progressChangeBlock;
/** 存放所有的完毕回调 */
@property (copy, nonatomic) MJDownloadStateChangeBlock stateChangeBlock;
/** 任务 */
@property (strong, nonatomic) NSURLSessionDataTask *task;
/** 文件流 */
@property (strong, nonatomic) NSOutputStream *stream;
@end
