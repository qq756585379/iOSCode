//
//  OTSNetworkAlert.m
//  OneStoreFramework
//
//  Created by 黄吉明 on 11/17/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSNetworkAlert.h"

@interface OTSNetworkAlert()
@property(nonatomic, strong) NSMutableDictionary *alertDict;
@end

@implementation OTSNetworkAlert

DEF_SINGLETON(OTSNetworkAlert)

#pragma mark - Property
- (NSMutableDictionary *)alertDict{
    if (_alertDict == nil) {
        _alertDict = [NSMutableDictionary dictionary];
    }
    return _alertDict;
}

/**
 *  功能:为某个error code注册提示语
 */
- (void)registAlertMsg:(NSString *)aMsg forErrorCode:(NSString *)aErrorCode{
    [self.alertDict safeSetObject:aMsg forKey:aErrorCode];
}

/**
 *  功能:返回error code对应的提示语
 */
- (NSString *)alertMsgForErrorCode:(NSString *)aErrorCode{
    return [self.alertDict safeObjectForKey:aErrorCode];
}

@end
