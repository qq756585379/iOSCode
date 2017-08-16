//
//  OTSNIAntiBrush.h
//  OneStoreNI
//
//  Created by huangjiming on 12/29/15.
//  Copyright © 2015 OneStoreNI. All rights reserved.
//

#import "OTSNetworkInterface.h"

@interface OTSNIAntiBrush : OTSNetworkInterface

/**
 *  功能:获取验证码
 */
+ (OTSOperationParam *)getValidCodeWithCaptchaClientKey:(NSString *)aKey
                                        completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  功能:校验验证码
 */
+ (OTSOperationParam *)checkValidCode:(NSString *)aValidCode
                 withCaptchaClientKey:(NSString *)aKey
                      completionBlock:(OTSCompletionBlock)aBlock;

@end
