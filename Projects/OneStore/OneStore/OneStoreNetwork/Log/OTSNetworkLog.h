//
//  OTSNetworkLog.h
//  OneStoreFramework
//  功能:接口日志
//  Created by huang jiming on 14-8-6.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
//network
#import "OTSOperationParam.h"
//base
#import "OTSValueObject.h"

@interface OTSNetworkLog : OTSValueObject

AS_SINGLETON(OTSNetworkLog)

/**
 *  功能:保存接口日志
 */
- (void)saveLogWithParam:(OTSOperationParam * _Nullable)aParam;

/**
 *  功能:将本地保存的接口日志发送到服务器
 */
- (void)sendLog;

@end
