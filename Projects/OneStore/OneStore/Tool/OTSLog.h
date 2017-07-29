//
//  OTSLog.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

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

//log
#define LOG_PRETTY_FUNCTION      OTSLogV(@"%s", __PRETTY_FUNCTION__)
#define LOG_LINE_PRETTY_FUNCTION OTSLogV(@"line[%d] %s", __LINE__, __PRETTY_FUNCTION__)
//func log
#define OTSLogFuncV OTSLogV(@"[%@ call %@]", [self class], THIS_METHOD)
#define OTSLogFuncD OTSLogD(@"[%@ call %@]", [self class], THIS_METHOD)
#define OTSLogFuncI OTSLogI(@"[%@ call %@]", [self class], THIS_METHOD)
#define OTSLogFuncW OTSLogW(@"[%@ call %@]", [self class], THIS_METHOD)
#define OTSLogFuncE OTSLogE(@"[%@ call %@]", [self class], THIS_METHOD)

@interface OTSLog : NSObject

+ (void)setupLogerStatus;

@end

