//
//  OTSTimeOutError.h
//  OneStoreFramework
//
//  Created by 黄吉明 on 11/26/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSNetworkError.h"

@interface OTSTimeOutError : OTSNetworkError

AS_SINGLETON(OTSTimeOutError)

/**
 *  功能:添加接口超时rtn_code
 */
- (void)addTimeOutRtnCode:(NSString *)aRtnCode;

/**
 *  功能:判断某个rtn_code是否是超时rtn_code
 */
- (BOOL)timeOutForRtnCode:(NSString *)aRtnCode;

@end
