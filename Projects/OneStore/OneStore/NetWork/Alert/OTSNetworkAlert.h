//
//  OTSNetworkAlert.h
//  OneStoreFramework
//
//  Created by 黄吉明 on 11/17/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSNetworkAlert : NSObject

AS_SINGLETON(OTSNetworkAlert)

/**
 *  功能:为某个error code注册提示语
 */
- (void)registAlertMsg:(NSString *)aMsg forErrorCode:(NSString *)aErrorCode;

- (NSString *)alertMsgForErrorCode:(NSString *)aErrorCode;

@end
