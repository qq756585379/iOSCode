//
//  NetworkLog.h
//  OneStoreFramework
//  功能:接口日志VO
//  Created by huang jiming on 14-8-7.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSManagedObject.h"

@interface NetworkLog : OTSManagedObject

@property(nonatomic, copy) NSString *networkLog;
@property(nonatomic, copy) NSDate *saveTime;//保存时间

@end
