//
//  OTSLog.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#define IMIDDLog(format, ...) DDLogVerbose((@"\n ******************************* \n[文件名:%s]" "\n[函数名:%s]" "\n[行号:%d]\n" format), [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String], __FUNCTION__, __LINE__, ##__VA_ARGS__);

//新增log level用作log日志
#define LOG_FLAG_DATA_TO_FILE      (1 << 5)  // 0...100000
#define DDLogDataToFile(frmt, ...) LOG_MAYBE(NO, LOG_LEVEL_DEF, LOG_FLAG_DATA_TO_FILE, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#ifdef DEBUG
// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = (DDLogLevelVerbose | LOG_FLAG_DATA_TO_FILE);
#define NSLog(...) NSLog(__VA_ARGS__)
#else       //发布模式
static const DDLogLevel ddLogLevel = DDLogLevelOff;
//干掉log
#define NSLog(...) {}
//干掉断言
#define NS_BLOCK_ASSERTIONS
#endif

#define OTSLogV(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)
#define OTSLogD(frmt, ...) DDLogDebug(frmt, ##__VA_ARGS__)
#define OTSLogI(frmt, ...) DDLogInfo(frmt, ##__VA_ARGS__)
#define OTSLogW(frmt, ...) DDLogWarn(frmt, ##__VA_ARGS__)
#define OTSLogE(frmt, ...) DDLogError(frmt, ##__VA_ARGS__)
#define OTSLogF(frmt, ...) DDLogDataToFile(frmt, ##__VA_ARGS__) //log日志专用

//func log
#define OTSLogFuncV OTSLogV(@"[%@ call %@] line[%d] %s", [self class], THIS_METHOD, __LINE__, __PRETTY_FUNCTION__)
#define OTSLogFuncD OTSLogD(@"[%@ call %@] line[%d] %s", [self class], THIS_METHOD, __LINE__, __PRETTY_FUNCTION__)
#define OTSLogFuncI OTSLogI(@"[%@ call %@] line[%d] %s", [self class], THIS_METHOD, __LINE__, __PRETTY_FUNCTION__)
#define OTSLogFuncW OTSLogW(@"[%@ call %@] line[%d] %s", [self class], THIS_METHOD, __LINE__, __PRETTY_FUNCTION__)
#define OTSLogFuncE OTSLogE(@"[%@ call %@] line[%d] %s", [self class], THIS_METHOD, __LINE__, __PRETTY_FUNCTION__)

@interface OTSLog : NSObject
/*
 CoCoaLumberJack配置
 AppDelegate.h里在didFinishLaunchingWithOptions中添加如下代码:
 */
+ (void)setupLogerStatus;

+ (NSArray *)getLogPath;

@end

