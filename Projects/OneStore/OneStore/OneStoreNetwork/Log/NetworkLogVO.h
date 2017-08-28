//
//  NetworkLogVO.h
//  OneStoreFramework
//
//  Created by 黄吉明 on 11/30/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

//global
#import "OTSClientInfo.h"
//base
#import "OTSValueObject.h"

@interface NetworkLogVO : OTSValueObject

@property(nonatomic, strong) NSString *methodname;
@property(nonatomic, strong) NSNumber *duration;//接口耗时，精确到毫秒
@property(nonatomic, strong) NSNumber *errortype;
@property(nonatomic, strong) NSString *timestamp;//时间戳，精确到秒
@property(nonatomic, strong) NSNumber *provinceId;
@property(nonatomic, strong) OTSClientInfo *trader;

@end
