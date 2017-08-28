//
//  NSString+RSASecurity.h
//  OneStoreFramework
//
//  Created by Vect Xi on 9/18/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OTSRSAKeyType) {
    OTSRSAKeyTypePublic,
    OTSRSAKeyTypePrivate,
};

@interface NSString (RSASecurity)

/**
 *  RSA加密字符串。
 *  加密流程：RSA encrypt --> base64 encode
 *
 *  @param textKey   RSA秘钥
 *  @param keyType   秘钥类型（私钥 or 公钥）
 *  @param anError   返回的错误信息
 *
 *  @return 加密并base64后的密文（NSUTF8StringEncoding）
 */
- (NSString *)encryptByRSAKey:(NSString *)textKey
                    keyType:(OTSRSAKeyType)keyType
                      error:(NSError *__autoreleasing *)anError;
- (NSString *)encryptByRSAKeyWithKeyType:(OTSRSAKeyType)keyType
                                   error:(NSError *__autoreleasing *)anError;

/**
 *  RSA解密字符。
 *  解密流程：base64 decode --> RSA decrypt --> to string(NSUTF8StringEncoding)
 *
 *  @param key         RSA秘钥
 *  @param keyType     秘钥类型（私钥 or 公钥）
 *  @param anError     返回的错误信息
 *
 *  @return 明文数据
 */
- (NSString *)decryptByRSAKey:(NSString *)textKey
                    keyType:(OTSRSAKeyType)keyType
                      error:(NSError *__autoreleasing *)anError;
- (NSString *)decryptByRSAKeyWithKeyType:(OTSRSAKeyType)keyType
                        error:(NSError *__autoreleasing *)anError;

@end
