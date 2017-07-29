//
//  OTSLog.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLog.h"
#import "OTSFileManager.h"

@implementation OTSLog

/**
 1.DDLog（整个框架的基础）
 2.DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
 3.DDTTYLoyger（发送日志语句到Xcode控制台，如果可用）
 4.DDFIleLoger（把日志语句发送至文件）
 DDLog是强制性的，其余的都是可选的，这取决于你打算如何使用这个框架。例如，如果你不打算纪录到一个文件，你可以跳过DDFileLogger，或者你想跳过ASL以便更快的文件记录，你可以跳过DDASLLoger。
 
 安装Alcatraz后，直接window -> package manage 搜索 XcodeColors就可以安装了。
 或者，到XcodeColors所在的gitHub页面，下载源文件，运行程序。重启Xcode，插件会自动装载到Xcode上。
 打开Product -> Edit Scheme
 选择Run->"Arguments" tab
 增加一个新的Environment Variable ，命名为"XcodeColors"，值赋为YES
 */

+ (void)setupLogerStatus{
#ifdef DEBUG
    //set color on
    setenv("XcodeColors", "YES", 0);
    
    //This class provides a logger for Terminal output or Xcode console output
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //This class provides a logger for the Apple System Log facility
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    //在硬盘上存储接口数据和tracker
    NSString *logPath = [[OTSFileManager appCachePath] stringByAppendingString:@"/Logs"];
    if ([OTSFileManager isFileExsit:logPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];
    }
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 0;
    fileLogger.maximumFileSize = 0;
    [DDLog addLogger:fileLogger withLevel:LOG_FLAG_DATA_TO_FILE];
    
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor cyanColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor magentaColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
#endif
}

+ (NSArray *)getLogPath{
    NSString *libPath = [OTSFileManager appLibPath];
    
    NSString *logPath = [libPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray *listArray = [NSMutableArray array];
    for (NSString *oneLogPath in fileList){
        if([oneLogPath hasSuffix:@".log"]){
            NSString *truePath = [logPath stringByAppendingPathComponent:oneLogPath];
            [listArray addObject:truePath];
        }
    }
    return listArray;
}

@end




