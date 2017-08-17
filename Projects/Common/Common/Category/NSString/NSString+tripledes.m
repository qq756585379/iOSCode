//
//  NSString+tripledes.m
//  demo
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 赵大成. All rights reserved.
//

#import "NSString+tripledes.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (tripledes)

+ (NSString *)getHciTokenTripleDESStringWithDictionary:(NSMutableDictionary*)hciTekonDictionary
{
    //转成json格式
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:hciTekonDictionary options:0 error:nil];
    NSString *hciTokenString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"hciTokenString== %@",hciTokenString);
    
    //base64
    NSString *hciString = [NSString stringWithFormat:@"%@",hciTokenString];
    NSData * hciData = [hciString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * hciBase64 = [hciData base64EncodedDataWithOptions:0];
    
    //reverse
    NSMutableData * hciTokenData = [[NSMutableData alloc] init];
    NSData * mdata;
    for (NSInteger i = hciBase64.length; i > 0; i--) {
        mdata = [hciBase64 subdataWithRange:NSMakeRange(i-1, 1)];
        [hciTokenData appendData:mdata];
    }
    
    //tripLeDES加密
    NSString *desKey = @"3Bq4z2p0eUJ7eDndWPDoQ2wI";
    size_t plainTextBufferSize = [hciTokenData length];
    const void *vplainText = (const void *)[hciTokenData bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *) [desKey UTF8String];
    //偏移量
    const void *vinitVec = nil;
    //配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionECBMode|kCCOptionPKCS7Padding, //设置模式
                       vkey,  //key
                       kCCKeySize3DES,
                       vinitVec,   //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString * hciTokenTripleDESString = [myData base64EncodedStringWithOptions:0];
    
    return hciTokenTripleDESString;
}

@end
