//
//  YJDownload.h
//  Demos
//
//  Created by 杨俊 on 2017/11/3.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

typedef enum {
    MJDownloadStateNone = 0,     // 闲置状态（除后面几种状态以外的其他状态）
    MJDownloadStateWillResume,   // 即将下载（等待下载）
    MJDownloadStateResumed,      // 下载中
    MJDownloadStateSuspened,     // 暂停中
    MJDownloadStateCompleted     // 已经完全下载完毕
}YJDownloadState;


/**
 *  跟踪下载进度的Block回调
 *
 *  @param bytesWritten              【这次回调】写入的数据量
 *  @param totalBytesWritten         【目前总共】写入的数据量
 *  @param totalBytesExpectedToWrite 【最终需要】写入的数据量
 */
typedef void (^MJDownloadProgressChangeBlock)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite);
/**
 *  状态改变的Block回调
 *
 *  @param file 文件的下载路径
 *  @param error    失败的描述信息
 */
typedef void (^MJDownloadStateChangeBlock)(MJDownloadState state, NSString *file, NSError *error);
