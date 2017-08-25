//
//  OTSTimeOutError.m
//  OneStoreFramework
//
//  Created by 黄吉明 on 11/26/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSTimeOutError.h"
//category
#import "NSMutableArray+safe.h"

@interface OTSTimeOutError()

@property(nonatomic, strong) NSMutableArray *timeOutRtnCodes;

@end

@implementation OTSTimeOutError

DEF_SINGLETON(OTSTimeOutError)

#pragma mark - Property
- (NSMutableArray *)timeOutRtnCodes
{
    if (_timeOutRtnCodes == nil) {
        _timeOutRtnCodes = [NSMutableArray array];
    }
    
    return _timeOutRtnCodes;
}

#pragma mark - API
/**
 *  功能:添加接口超时rtn_code
 */
- (void)addTimeOutRtnCode:(NSString *)aRtnCode
{
    [self.timeOutRtnCodes safeAddObject:aRtnCode];
}

/**
 *  功能:判断某个rtn_code是否是超时rtn_code
 */
- (BOOL)timeOutForRtnCode:(NSString *)aRtnCode
{
    if (aRtnCode == nil) {
        return NO;
    }
    
    return [self.timeOutRtnCodes containsObject:aRtnCode];
}



@end
