//
//  OTSAntiBrushError.m
//  OneStoreNetwork
//
//  Created by huangjiming on 12/24/15.
//  Copyright © 2015 OneStoreNetwork. All rights reserved.
//

#import "OTSAntiBrushError.h"
//category
#import "NSMutableDictionary+safe.h"

@interface OTSAntiBrushError ()
@property(nonatomic, strong) NSMutableSet *antiBrushRtnCodes;//所有防刷错误码,set<NSString>类型
@end

@implementation OTSAntiBrushError

DEF_SINGLETON(OTSAntiBrushError)

- (NSMutableSet *)antiBrushRtnCodes{
    if (_antiBrushRtnCodes == nil) {
        _antiBrushRtnCodes = [NSMutableSet set];
    }
    return _antiBrushRtnCodes;
}

/**
 *  功能:添加防刷rtn_code
 */
- (void)addAntiBrushRtnCode:(NSString *)aRtnCode{
    [self.antiBrushRtnCodes addObject:aRtnCode];
}

/**
 *  功能:aRtnCode是否是防刷错误码
 */
- (BOOL)antiBrushForRtnCode:(NSString *)aRtnCode{
    if ([self.antiBrushRtnCodes containsObject:aRtnCode]) {
        return YES;
    }
    return NO;
}

/**
 *  功能:防刷的错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(OTSOperationManager *)aManager
                  param:(OTSOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError{
    if (self.antiBrushErrorHandleBlock != nil) {
        self.antiBrushErrorHandleBlock(aResponseObject);
    }
    return YES;
}

@end
