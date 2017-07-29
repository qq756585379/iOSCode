//
//  GoodReceiverVO.m
//  ProtocolDemo
//
//  Created by vsc on 11-2-10.
//  Copyright 2011 vsc. All rights reserved.
//

#import "GrouponGoodReceiverVO.h"


@implementation GrouponGoodReceiverVO

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.countryId = [NSNumber numberWithInt:1];
        self.countryName = @"中国";
    }
    return self;
}

- (NSString *)regionString
{
    NSString *regionStr;
    
    if ([self.provinceName isEqualToString:@"上海"]) {
        regionStr = [NSString stringWithFormat:@"%@ %@"
                     , self.provinceName
                     , self.cityName];
    } else {
        regionStr = [NSString stringWithFormat:@"%@ %@ %@"
                     , self.provinceName
                     , self.cityName
                     , self.countyName];
    }
    
    return regionStr;
}

- (NSString *)toXML
{
    NSMutableString *string = [[NSMutableString alloc] safeInitWithString:@"<com.yihaodian.mobile.vo.address.GoodReceiverVO>"];
    if ([self address1] != nil) {
        [string appendFormat:@"<address1>%@</address1>",[self address1]];
    }
    if ([self cityId] != nil) {
        [string appendFormat:@"<cityId>%@</cityId>",[self cityId]];
    }
    if ([self cityName] != nil) {
        [string appendFormat:@"<cityName>%@</cityName>",[self cityName]];
    }
    if ([self countryId] != nil) {
        [string appendFormat:@"<countryId>%@</countryId>",[self countryId]];
    }
    if ([self countryName] != nil) {
        [string appendFormat:@"<countryName>%@</countryName>",[self countryName]];
    }
    if ([self countyId] != nil) {
        [string appendFormat:@"<countyId>%@</countyId>",[self countyId]];
    }
    if ([self countyName] != nil) {
        [string appendFormat:@"<countyName>%@</countyName>",[self countyName]];
    }
    if ([self defaultAddressId] != nil) {
        [string appendFormat:@"<defaultAddressId>%@</defaultAddressId>",[self defaultAddressId]];
    }
    if ([self nid] != nil) {
        [string appendFormat:@"<id>%@</id>",[self nid]];
    }
    if ([self mcsiteid] != nil) {
        [string appendFormat:@"<mcsiteid>%@</mcsiteid>",[self mcsiteid]];
    }
    if ([self postCode] != nil) {
        [string appendFormat:@"<postCode>%@</postCode>",[self postCode]];
    }
    if ([self provinceId] != nil) {
        [string appendFormat:@"<provinceId>%@</provinceId>",[self provinceId]];
    }
    if ([self provinceName] != nil) {
        [string appendFormat:@"<provinceName>%@</provinceName>",[self provinceName]];
    }
    if ([self receiveName] != nil) {
        [string appendFormat:@"<receiveName>%@</receiveName>",[self receiveName]];
    }
    if ([self receiverEmail] != nil) {
        [string appendFormat:@"<receiverEmail>%@</receiverEmail>",[self receiverEmail]];
    }
    if ([self receiverMobile] != nil) {
        [string appendFormat:@"<receiverMobile>%@</receiverMobile>",[self receiverMobile]];
    }
    if ([self receiverPhone] != nil) {
        [string appendFormat:@"<receiverPhone>%@</receiverPhone>",[self receiverPhone]];
    }
    if ([self recordName] != nil) {
        [string appendFormat:@"<recordName>%@</recordName>",[self recordName]];
    }
    if ([self isDefault] != nil) {
        [string appendFormat:@"<isDefault>%@</isDefault>",[self isDefault]];
    }
    [string safeAppendString:@"</com.yihaodian.mobile.vo.address.GoodReceiverVO>"];
    return string;
}

- (NSString *)provinceName
{
    if (_provinceName == nil) {
        return @"";
    }
    return _provinceName;
}

- (NSString *)cityName
{
    if (_cityName == nil) {
        return @"";
    }
    return _cityName;
}

- (NSString *)address1
{
    if (_address1 == nil) {
        return @"";
    }
    return _address1;
}

@end
