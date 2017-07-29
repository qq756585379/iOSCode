//
//  OTSBIGlobalValue.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSBIGlobalValue.h"
#import "OTSUserDefault.h"
#import "OTSUserDefaultDefine.h"

@implementation OTSBIGlobalValue

HMSingletonM

// 获取合适的 sessionId
- (NSString *)generateSessionId{
    // 获取sessionID
    NSDate *currentDate = [NSDate date];
    NSDate *formerDate = [OTSUserDefault getValueForKey:BI_SessionTimeOut];
    NSTimeInterval time = [currentDate timeIntervalSinceDate:formerDate];
    if ((int)time/3600>=24 || formerDate==nil || (int)time==0) {// 时间过期或者为空
        [self creatNewSessionId];
        // 每次更换session的时候同理清空打开渠道，在OTSNC里面，每次设置新值的时候会先检查一下，不用担心
        [OTSUserDefault setValue:nil forKey:BI_OpenTrucku];
        // 超过时间将 扩展字段 w_tu,w_ak,w_ck 清空
        self.trackerUrl = nil;
        self.keywordId = nil;
        self.websiteAndUid = nil;
        self.website = nil;
        self.uid = nil;
    }
    return [OTSUserDefault getValueForKey:BI_SessionId];
}

// 生成sessionid
- (void)creatNewSessionId{
    int NUMBER_OF_CHARS = 32;
    char data[NUMBER_OF_CHARS];
    for (int x=0; x<NUMBER_OF_CHARS; x++) {
        if (arc4random()%2) {
            data[x] = (char)('A' + (arc4random_uniform(26)));
        } else {
            data[x] = (char)((arc4random() % 10) + '0');
        }
    }
    NSString *sessionId = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    [OTSUserDefault setValue:sessionId forKey:BI_SessionId];
    [OTSUserDefault setValue:[NSDate date] forKey:BI_SessionTimeOut];
}

// 获取系统当前时间
-(NSString *)client_time{
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[currentDate timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.f", time];
    return timeStr;
}

@end
