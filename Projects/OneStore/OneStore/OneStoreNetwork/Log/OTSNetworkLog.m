//
//  OTSNetworkLog.m
//  OneStoreFramework
//
//  Created by huang jiming on 14-8-6.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSNetworkLog.h"
#import "NetworkLogVO.h"
#import "NetworkLog.h"
#import "OTSCoreDataManager.h"
#import "NSObject+JsonToVO.h"
#import "OTSJsonKit.h"
#import "OTSNetworkManager.h"
#import "OTSReachability.h"
//network
#import "OTSOperationManager.h"
//category
#import "NSArray+safe.h"
#import "NSMutableDictionary+safe.h"
//global
#import "OTSGlobalValue.h"
#import "OTSCurrentAddress.h"

#define LOG_COREDATA @"Model.momd"
#define FETCH_LIMIT_FOR_NOT_WIFT    100
#define FETCH_LIMIT_FOR_WIFT        50

@interface OTSNetworkLog()
//@property(nonatomic, strong) OTSClientInfo *clientInfo;//client info
@property(nonatomic, copy) NSString *requestUrl;//请求url
@property(nonatomic, strong) NSNumber *costTime;//耗费时间
@property(nonatomic, copy) NSString *netType;//网络类型
@property(nonatomic, strong) NSNumber *errorType;//0:无错误 1:接口超时 2:接口错误 3:rtn_code不为0
@property(nonatomic, copy) NSString *errorCode;//rtn_code不为0时的错误码
@property(nonatomic, strong) NSNumber *timeStamp;//当前时间戳，精确到秒
@property(nonatomic, strong) OTSOperationManager *operationManger;
@property(nonatomic, strong) OTSCoreDataManager *coreDataManager;
@end

@implementation OTSNetworkLog

DEF_SINGLETON(OTSNetworkLog)

- (id)init
{
    self = [super init];
    if (self != nil) {
        [self deleteOldLogs];
    }
    return self;
}

#pragma mark - Property
- (OTSOperationManager *)operationManger
{
    if (_operationManger == nil) {
        _operationManger = [[OTSNetworkManager sharedInstance] generateOperationMangerWithOwner:self];
    }
    
    return _operationManger;
}

- (OTSCoreDataManager *)coreDataManager
{
    if (_coreDataManager == nil) {
        _coreDataManager = [OTSCoreDataManager managerWithCoreDataPath:LOG_COREDATA];
    }
    
    return _coreDataManager;
}

#pragma mark - Inner
/**
 *  功能:删除30天以前的日志
 */
- (void)deleteOldLogs
{
    NSArray *networkLogs = [self.coreDataManager fetchWithEntityName:[NetworkLog class] predicate:nil pageSize:@100 sortDescriptors:nil].copy;
    for (NetworkLog *networkLog in networkLogs) {
        NSDate *saveTime = networkLog.saveTime;
        NSTimeInterval timeInterval = [saveTime timeIntervalSinceNow];
        if (saveTime==nil || timeInterval < -30*24*3600) {
            [self.coreDataManager deleteWithManageObject:networkLog];
        }
    }
}

#pragma mark - API

- (void)saveLogWithParam:(OTSOperationParam *)aParam
{
    if (aParam.methodName.length <= 0) {//没有接口名字的不保存
        return;
    }
    if ([aParam.methodName rangeOfString:@"/mobilelog/receive.action"].location != NSNotFound) {//发送日志接口不保存
        return;
    }
    if (aParam.errorType != 0) {//rtn_code不为0的不保存
        return;
    }
    
    NetworkLogVO *logVO = [[NetworkLogVO alloc] init];
    //方法名
    NSString *frontStr = [[aParam.methodName componentsSeparatedByString:@"?"] safeObjectAtIndex:0];
    NSArray *componets = [frontStr componentsSeparatedByString:@"/"];
    if (componets.count > 1) {
        NSString *businessN = [componets safeObjectAtIndex:componets.count-2];
        NSString *methodN = [componets lastObject];
        logVO.methodname = [NSString stringWithFormat:@"/%@/%@", businessN, methodN];
    } else {
        logVO.methodname = [NSString stringWithFormat:@"/%@/%@", aParam.businessName, aParam.methodName];
    }
    
    //耗时
    logVO.duration = @(aParam.endTimeStamp - aParam.startTimeStamp);
    
    //时间戳
    NSTimeInterval dTime = [OTSGlobalValue sharedInstance].dTime;//服务器时间-本地时间
    long long serverTimeStamp = ([[NSDate date] timeIntervalSince1970]+dTime) * 1000;//精确到毫秒
    logVO.timestamp = [NSString stringWithFormat:@"%lld", serverTimeStamp];
    //接口错误类型
    logVO.errortype = [NSNumber numberWithInteger:aParam.errorType];
    //省份id
    logVO.provinceId = [NSNumber numberWithInteger:[OTSCurrentAddress sharedInstance].currentProvinceId.integerValue];
    //trader
    logVO.trader = [OTSClientInfo sharedInstance];
    //存储
    NSString *theStr = [logVO toJSONString];
    [self.coreDataManager insertAndWaitWithClass:[NetworkLog class] insertBlock:^(id entity) {
        NetworkLog *obj = (NetworkLog *)entity;
        obj.networkLog = theStr;
        obj.saveTime = [NSDate date];
    }];
}

/**
 *  功能:将本地保存的接口日志发送到服务器
 */
- (void)sendLog
{
    if ([OTSReachability sharedInstance].currentNetStatus == kConnectToWifi) {//连接到wifi才发送
        NSUInteger networkCount = [self.coreDataManager countWithEntityName:[NetworkLog class] Predicate:nil];
        NSArray *networkLogs;
        if (networkCount < FETCH_LIMIT_FOR_WIFT) {
            return;
        } else if (networkCount>=FETCH_LIMIT_FOR_WIFT && networkCount<FETCH_LIMIT_FOR_NOT_WIFT) {
            networkLogs = [self.coreDataManager fetchWithEntityName:[NetworkLog class] predicate:nil fetchLimit:FETCH_LIMIT_FOR_WIFT sortDescriptors:nil];
        } else {
            networkLogs = [self.coreDataManager fetchWithEntityName:[NetworkLog class] predicate:nil fetchLimit:FETCH_LIMIT_FOR_NOT_WIFT sortDescriptors:nil];
        }
        
        //拼装日志
        NSMutableString *allLogs = [[NSMutableString alloc] init];
        for (int i=0; i<networkLogs.count; i++) {
            NetworkLog* fetchedObj = (NetworkLog*)[networkLogs safeObjectAtIndex:i];
            NSString *oneLog = [fetchedObj networkLog];
            if (oneLog != nil) {
                if (i+1 == networkLogs.count) {
                    [allLogs appendFormat:@"%@", oneLog];
                } else {
                    [allLogs appendFormat:@"%@$", oneLog];
                }
            }
        }
        
        //发送日志
        if (allLogs.length > 0) {
            NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
            [mDict safeSetObject:allLogs forKey:@"message"];
            OTSOperationParam *param = [OTSOperationParam paramWithUrl:@"http://interface.m.yhd.com/mobilelog/receive.action" type:kRequestPost param:mDict callback:nil];
            param.needSignature = NO;
            [self.operationManger requestWithParam:param];
        }
        
        //删除日志
        [self.coreDataManager deleteAndWaitWithEntityName:[NetworkLog class] predicate:nil deleteCount:networkLogs.count];
        //继续发送
        if (networkCount > FETCH_LIMIT_FOR_NOT_WIFT) {
            [self sendLog];
        }
    }
}

@end
