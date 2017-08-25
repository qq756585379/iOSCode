//
//  OTSSignKeyExpireError.h
//  OneStoreFramework
//
//  Created by huangjiming on 9/19/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSNetworkError.h"
//define
#import "OTSFuncDefine.h"

@interface OTSSignKeyExpireError : OTSNetworkError

AS_SINGLETON(OTSSignKeyExpireError)

/**
 *  功能:添加密钥过期rtn_code
 */
- (void)addSignKeyExpireRtnCode:(NSString *)aRtnCode;

@end
