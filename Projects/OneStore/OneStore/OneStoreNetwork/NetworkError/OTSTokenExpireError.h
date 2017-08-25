//
//  OTSTokenExpireError.h
//  OneStoreFramework
//  功能:token过期错误处理
//  Created by huang jiming on 14-8-7.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSNetworkError.h"

@interface OTSTokenExpireError : OTSNetworkError

AS_SINGLETON(OTSTokenExpireError)

/**
 *  功能:添加token过期rtn_code
 */
- (void)addTokenExpireRtnCode:(NSString *)aRtnCode;

@end
