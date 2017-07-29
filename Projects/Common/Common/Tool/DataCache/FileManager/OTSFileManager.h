//
//  OTSFileManager.h
//  Common
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OTS_DOC_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]

@interface OTSFileManager : NSObject
/**
 *  获得app文档目录
 *
 *  @return 目录地址
 */
+ (NSString *)appDocPath;
/**
 *  获得app文档目录
 *
 *  @return 目录地址
 */
+ (NSString *)appCachePath;
/**
 *  获得app的lib目录
 *
 *  @return lib目录地址
 */
+ (NSString *)appLibPath;
/**
 *  判断文件是否存在
 *
 *  @param aPath 地址
 *
 *  @return BOOL
 */
+ (BOOL)isFileExsit:(NSString *)aPath;
/**
 *  判断Doc目录中是否存在某文件
 *
 *  @param aPath 地址
 *
 *  @return BOOL
 */
+ (BOOL)isFileExsitInDoc:(NSString *)aPath;
/**
 *  判断bundle是否存在
 *
 *  @param aBundleName bundle名称
 *
 *  @return BOOL
 */
+ (BOOL)isBundleExsit:(NSString *)aBundleName;


@end
