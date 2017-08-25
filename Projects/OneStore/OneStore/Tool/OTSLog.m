//
//  OTSLog.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLog.h"
#import "OTSFileManager.h"
#import "IMICatchCrash.h"

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
    //>检测是否开启 XcodeColors
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0)) {
        NSLog(@"XcodeColors is installed and enabled");
    }else{
        NSLog(@"XcodeColors is  not installed and unabled");
    }
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
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    fileLogger.maximumFileSize = 50 * 1024 * 1024; //50MB
    [DDLog addLogger:fileLogger withLevel:imiDDLogLevel];
    [DDLog addLogger:fileLogger withLevel:LOG_FLAG_DATA_TO_FILE];
    //上面的代码告诉应用程序要在系统上保持一周的日志文件。
    //如果不设置rollingFrequency和maximumNumberOfLogFiles，
    //则默认每天1个Log文件、存5天、单个文件最大1M、总计最大20M，否则自动清理最前面的记录。
    
    //若crash文件存在，则写入log并上传，然后删掉crash文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *errorLogPath = [NSString stringWithFormat:@"%@/Documents/IMICatchCrash.log", NSHomeDirectory()];
    if ([fileManager fileExistsAtPath:errorLogPath]) {
        [fileLogger.logFileManager createNewLogFile];
        //此处必须用firstObject而不能用lastObject，因为是按照日期逆序排列的，即最新的Log文件排在前面
        NSString *newLogFilePath = [fileLogger.logFileManager sortedLogFilePaths].firstObject;
        NSError *error = nil;
        NSString *errorLogContent = [NSString stringWithContentsOfFile:errorLogPath encoding:NSUTF8StringEncoding error:nil];
        BOOL isSuccess = [errorLogContent writeToFile:newLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (!isSuccess) {
            NSLog(@"crash文件写入log失败: %@", error.userInfo);
        } else {
            NSLog(@"crash文件写入log成功");
            NSError *error = nil;
            BOOL isSuccess = [fileManager removeItemAtPath:errorLogPath error:&error];
            if (!isSuccess) {
                NSLog(@"删除本地的crash文件失败: %@", error.userInfo);
            }
        }
        //上传最近的3个log文件，
        //至少要3个，因为最后一个是crash的记录信息，另外2个是防止其中后一个文件只写了几行代码而不够分析
        NSArray *logFilePaths = [fileLogger.logFileManager sortedLogFilePaths];
        NSUInteger logCounts = logFilePaths.count;
        if (logCounts >= 3) {
            for (NSUInteger i = 0; i < 3; i++) {
                //NSString *logFilePath = logFilePaths[i];
                //上传服务器
                
            }
        } else {
            for (NSUInteger i = 0; i < logCounts; i++) {
                //NSString *logFilePath = logFilePaths[i];
                //上传服务器
                
            }
        }
    }
    
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor cyanColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor magentaColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
    
    //注册消息处理函数的处理方法
    //如此一来，程序崩溃时会自动进入CatchCrash.m的uncaughtExceptionHandler()方法
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
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




