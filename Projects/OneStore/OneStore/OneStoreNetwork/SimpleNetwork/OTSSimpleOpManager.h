//
//  OTSSimpleOpManager.h
//  OneStoreNetwork
//
//  Created by huangjiming on 9/7/15.
//  Copyright (c) 2015 OneStoreNetwork. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface OTSSimpleOpManager : AFHTTPSessionManager

/**
 *  功能:http请求
 *  domain:domain url   param:参数
 */
- (void)requestWithDomain:(NSString *)domain param:(NSDictionary *)param;

/**
 *  功能:http请求
 *  urlStr:url
 */
- (void)requestWithFullUrlString:(NSString *)urlStr;

@end
