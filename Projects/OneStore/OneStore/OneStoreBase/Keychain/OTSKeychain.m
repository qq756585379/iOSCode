//
//  OTSKeychain.m
//  OneStoreFramework
//
//  Created by Aimy on 14-6-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSKeychain.h"

#import "KeychainItemWrapper.h"

#import "OTSLog.h"

#define OTS_KEYCHAIN_IDENTITY @"OneTheStore"

#define OTS_KEYCHAIN_GROUP @""

#define OTS_KEYCHAIN_DICT_ENCODE_KEY_VALUE @"OTS_KEYCHAIN_DICT_ENCODE_KEY_VALUE"

@interface OTSKeychain ()
@property (nonatomic, strong) KeychainItemWrapper *otsItem;
@property (nonatomic, strong) NSArray *commonClasses;
@end

@implementation OTSKeychain

DEF_SINGLETON(OTSKeychain);

- (id)init{
    if (self = [super init]) {
        self.commonClasses = @[[NSNumber class],
                               [NSString class],
                               [NSMutableString class],
                               [NSData class],
                               [NSMutableData class],
                               [NSDate class],
                               [NSValue class]];
        [self setup];
    }
    return self;
}

- (void)setup{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:OTS_KEYCHAIN_IDENTITY accessGroup:nil];
	self.otsItem = wrapper;
}

+ (void)setKeychainValue:(id<NSCopying, NSObject>)value forType:(NSString *)type{
    OTSKeychain *keychain = [OTSKeychain sharedInstance];
    __block BOOL find = NO;
    [keychain.commonClasses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Class class = obj;
        if ([value isKindOfClass:class]) {
            find = YES;
            *stop = YES;
        }
    }];
    
    if (!find && value) {
        OTSLogE(@"error set keychain type [%@], value [%@]",type ,value);
        return ;
    }
    
    if (!type || !keychain.otsItem) {
        return ;
    }
    
    id data = [keychain.otsItem objectForKey:(__bridge id)kSecValueData];
    NSMutableDictionary *dict = nil;
    if (data && [data isKindOfClass:[NSMutableData class]]) {
        dict = [keychain decodeDictWithData:data];
    }
    
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    
    dict[type] = value;
    data = [keychain encodeDict:dict];
    
    if (data && [data isKindOfClass:[NSMutableData class]]) {
        [keychain.otsItem setObject:OTS_KEYCHAIN_IDENTITY forKey:(__bridge id)(kSecAttrAccount)];
        [keychain.otsItem setObject:data forKey:(__bridge id)kSecValueData];
    }
}

+ (id)getKeychainValueForType:(NSString *)type{
    OTSKeychain *keychain = [OTSKeychain sharedInstance];
    if (!type || !keychain.otsItem) {
        return nil;
    }
    
    id data = [keychain.otsItem objectForKey:(__bridge id)kSecValueData];
    NSMutableDictionary *dict = nil;
    if (data && [data isKindOfClass:[NSMutableData class]]) {
        dict = [keychain decodeDictWithData:data];
    }
    return dict[type];
}

+ (void)reset{
    OTSKeychain *keychain = [OTSKeychain sharedInstance];
    if (!keychain.otsItem) {
        return ;
    }
    
    id data = [keychain encodeDict:[NSMutableDictionary dictionary]];
    
    if (data && [data isKindOfClass:[NSMutableData class]]) {
        [keychain.otsItem setObject:OTS_KEYCHAIN_IDENTITY forKey:(__bridge id)(kSecAttrAccount)];
        [keychain.otsItem setObject:data forKey:(__bridge id)kSecValueData];
    }
}

- (NSMutableData *)encodeDict:(NSMutableDictionary *)dict{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:OTS_KEYCHAIN_DICT_ENCODE_KEY_VALUE];
    [archiver finishEncoding];
    return data;
}

- (NSMutableDictionary *)decodeDictWithData:(NSMutableData *)data{
    NSMutableDictionary *dict = nil;
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    if ([unarchiver containsValueForKey:OTS_KEYCHAIN_DICT_ENCODE_KEY_VALUE]) {
        @try {
            dict = [unarchiver decodeObjectForKey:OTS_KEYCHAIN_DICT_ENCODE_KEY_VALUE];
        }
        @catch (NSException *exception) {
            OTSLogE(@"keychain 解析错误");
            [OTSKeychain reset];
        }
    }
    [unarchiver finishDecoding];
    
    return dict;
}

@end
