//
//  OTSServerError.h
//  OneStoreNetwork
//
//  Created by huangjiming on 4/12/16.
//  Copyright © 2016 OneStoreNetwork. All rights reserved.
//

#import "OTSNetworkError.h"
//define
#import "OTSFuncDefine.h"

#define IP_CACHE_TIME     14400               //dns ip缓存时间，单位秒，4小时

@interface OTSServerError : OTSNetworkError

AS_SINGLETON(OTSServerError)

@property(nonatomic, copy) NSString *serverDomain;//服务器域名
@property(nonatomic, copy) NSString *serverIp;//服务器ip地址
@property(nonatomic, copy) NSDate *serverIpUseTime;//服务器ip地址使用时间

/**
 *  功能:当前错误是否是服务器错误的错误码
 */
- (BOOL)serverErrorForError:(NSError *)aError
                  withParam:(OTSOperationParam *)aParam;

/**
 *  功能:获取ip
 */
- (NSString *)getServerIp:(NSString *)requestUrl;

@end
