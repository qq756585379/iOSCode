//
//  GoodReceiverVO.h
//  ProtocolDemo
//
//  Created by vsc on 11-2-10.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GrouponGoodReceiverVO : OTSValueObject

@property(retain, nonatomic) NSString *address1;
@property(retain, nonatomic) NSNumber *cityId;
@property(retain, nonatomic) NSString *cityName;
@property(retain, nonatomic) NSNumber *countryId;
@property(retain, nonatomic) NSString *countryName;
@property(retain, nonatomic) NSNumber *countyId;
@property(retain, nonatomic) NSString *countyName;
@property(retain, nonatomic) NSNumber *defaultAddressId;
@property(retain, nonatomic) NSNumber *nid;//收获地址Id
@property(retain, nonatomic) NSNumber *mcsiteid;
@property(retain, nonatomic) NSString *postCode;
@property(retain, nonatomic) NSNumber *provinceId;
@property(retain, nonatomic) NSString *provinceName;
@property(retain, nonatomic) NSString *receiveName;
@property(retain, nonatomic) NSString *receiverEmail;
@property(retain, nonatomic) NSString *receiverMobile;
@property(retain, nonatomic) NSString *receiverPhone;
@property(retain, nonatomic) NSString *recordName;
@property(retain, nonatomic) NSNumber *isDefault;//是否常用地址    private Integer isDefault = null
#pragma mark - 客户端字段
@property(nonatomic, assign) BOOL currentSelected;//是否是当前选中的收货地址

- (NSString *)regionString;
- (NSString *)toXML;

@end
