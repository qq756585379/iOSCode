//
//  OTSNIAntiBrush.m
//  OneStoreNI
//
//  Created by huangjiming on 12/29/15.
//  Copyright © 2015 OneStoreNI. All rights reserved.
//

#import "OTSNIAntiBrush.h"

@implementation OTSNIAntiBrush

/**
 *  功能:获取验证码
 */
+ (OTSOperationParam *)getValidCodeWithCaptchaClientKey:(NSString *)aKey
                                        completionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    paramDict[@"captchaClientKey"] = aKey;
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:@"http://fort.yhd.com/validate/getValidCode.do" type:kRequestGet param:paramDict callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    return param;
}

/**
 *  功能:校验验证码
 */
+ (OTSOperationParam *)checkValidCode:(NSString *)aValidCode
                 withCaptchaClientKey:(NSString *)aKey
                      completionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    paramDict[@"validateCon"] = aValidCode;
    paramDict[@"captchaClientKey"] = aKey;
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:@"http://fort.yhd.com/validate/checkValidCode.do" type:kRequestGet param:paramDict callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

@end
