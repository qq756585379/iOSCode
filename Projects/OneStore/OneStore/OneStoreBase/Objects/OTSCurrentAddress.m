//
//  OTSCurrentAddress.m
//  OneStoreBase
//
//  Created by huangjiming on 10/13/15.
//  Copyright © 2015 OneStoreBase. All rights reserved.
//

#import "OTSCurrentAddress.h"
//cache
#import "OTSUserDefault.h"
#import "OTSFileManager.h"
//global
#import "OTSGlobalValue.h"
//category
#import "NSNumber+safe.h"

#define OTS_KEY_CURRENT_ADDRESS @"OTS_DEF_KEY_CURRENT_ADDRESS"

@interface OTSCurrentAddress()
@property(nonatomic, copy) NSNumber *currentProvinceId;//当前省份id
@property(nonatomic, copy) NSString *currentProvinceName;//当前省份名称
@property(nonatomic, copy) NSNumber *currentCityId;//当前城市id
@property(nonatomic, copy) NSString *currentCityName;//当前城市名称
@property(nonatomic, copy) NSNumber *currentCountyId;//当前区域id
@property(nonatomic, copy) NSString *currentCountyName;//当前区域名称
@end

@implementation OTSCurrentAddress

+ (OTSCurrentAddress *)sharedInstance {
    static dispatch_once_t once;
    static OTSCurrentAddress * __singleton__;
    dispatch_once(&once, ^{
        NSData *currentAddressData = [OTSUserDefault getValueForKey:OTS_KEY_CURRENT_ADDRESS];
        if (currentAddressData) {
            __singleton__ = [NSKeyedUnarchiver unarchiveObjectWithData:currentAddressData];
        }
        if (!__singleton__) {
            __singleton__ = [[OTSCurrentAddress alloc] init];
        }
    });
    return __singleton__;
}

- (id)init{
    self = [super init];
    if (self != nil) {
        _currentProvinceId = @1;
        _currentProvinceName = @"上海";
        _currentCityId = @1;
        _currentCityName = @"上海市";
        _currentCountyId = @3;
        _currentCountyName = @"黄浦区";
        
#ifdef DEBUG
        _displayAddress = @"浦东新区祖冲之路296号";
        _rayProvinceId = [NSNumber numberWithInteger:42901];
        _lat = [NSNumber numberWithDouble:31.208576];
        _lng = [NSNumber numberWithDouble:121.549820];
        _supportMerchant = [NSNumber numberWithInteger:1];
        _blockId = [NSNumber numberWithInteger:1164];
        _rayCity = @"上海";
#endif
    }
    return self;
}

#pragma mark - Inner
- (void)saveAddressToLocal{
    NSData *currentAddressData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [OTSUserDefault setValue:currentAddressData forKey:OTS_KEY_CURRENT_ADDRESS];
}

#pragma mark - API
- (void)changeProvinceWithProvinceName:(NSString *)aProvinceName{
    if (aProvinceName.length <= 0) {
        return;
    }
    if (![self.currentProvinceName isEqualToString:aProvinceName]) {
        self.currentProvinceName = aProvinceName;
        
        NSArray *array = [[self class] allProvincesArray];
        for (NSDictionary *provinceDict in array) {
            NSString *provinceName = provinceDict[@"provinceName"];
            if ([provinceName isEqualToString:aProvinceName]) {
                NSArray *cityVoList = provinceDict[@"cityVoList"];
                NSDictionary *cityDict = cityVoList.firstObject;
                NSArray *countyVoList = cityDict[@"countyVoList"];
                NSDictionary *countyDict = countyVoList.firstObject;
                self.currentProvinceId = provinceDict[@"id"];
                self.currentCityId = cityDict[@"id"];
                self.currentCityName = cityDict[@"cityName"];
                self.currentCountyId = countyDict[@"id"];
                self.currentCountyName = countyDict[@"countyName"];
                break;
            }
        }
    }
    [self saveAddressToLocal];
}

- (void)updateAddressWithProvinceName:(NSString *)aProvinceName cityName:(NSString *)aCityName countyName:(NSString *)aCountyName{
    if (aProvinceName.length <= 0 || aCityName.length <= 0 || aCountyName.length <= 0) {
        return;
    }
    
    NSArray *array = [[self class] allProvincesArray];
    for (NSDictionary *provinceDict in array) {
        NSString *provinceName = provinceDict[@"provinceName"];
        if ([provinceName isEqualToString:aProvinceName]) {
            self.currentProvinceName = aProvinceName;
            self.currentProvinceId = provinceDict[@"id"];
            NSArray *cityVoList = provinceDict[@"cityVoList"];
            for (NSDictionary *cityDict in cityVoList) {
                NSString *cityName = cityDict[@"cityName"];
                if ([cityName isEqualToString:aCityName]) {
                    self.currentCityId = cityDict[@"id"];
                    self.currentCityName = cityDict[@"cityName"];
                    NSArray *countyVoList = cityDict[@"countyVoList"];
                    for (NSDictionary *countyDict in countyVoList) {
                        NSString *countyName = countyDict[@"countyName"];
                        if ([countyName isEqualToString:aCountyName]) {
                            self.currentCountyId = countyDict[@"id"];
                            self.currentCountyName = countyDict[@"countyName"];
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    [self saveAddressToLocal];
}

-(BOOL)checkIsDefaultAddress{
    if ([self.currentProvinceId safeIsEqualToNumber:@1] && [self.currentCityId safeIsEqualToNumber:@1] && [self.currentCountyId safeIsEqualToNumber:@3]) {
        return YES;
    }
    return NO;
}

-(void)changeToDefaultAddress{
    self.currentProvinceId = @1;
    self.currentProvinceName = @"上海";
    self.currentCityId = @1;
    self.currentCityName = @"上海市";
    self.currentCountyId = @3;
    self.currentCountyName = @"黄浦区";
    
    [self saveAddressToLocal];
}

- (void)changeProvinceWithProvinceId:(NSNumber *)aProvinceId{
    if (aProvinceId==nil || ![aProvinceId isKindOfClass:[NSNumber class]]) {
        return;
    }
    
    if (![self.currentProvinceId safeIsEqualToNumber:aProvinceId]) {
        self.currentProvinceId = aProvinceId;
        
        NSArray *provinceArray = [[self class] allProvincesArray];
        for (NSDictionary *provinceDict in provinceArray) {
            NSNumber *provinceId = provinceDict[@"id"];
            if ([provinceId safeIsEqualToNumber:aProvinceId]) {
                NSArray *cityVoList = provinceDict[@"cityVoList"];
                NSDictionary *cityDict = cityVoList.firstObject;
                NSArray *countyVoList = cityDict[@"countyVoList"];
                NSDictionary *countyDict = countyVoList.firstObject;
                self.currentProvinceName = provinceDict[@"provinceName"];
                self.currentCityId = cityDict[@"id"];
                self.currentCityName = cityDict[@"cityName"];
                self.currentCountyId = countyDict[@"id"];
                self.currentCountyName = countyDict[@"countyName"];
                break;
            }
        }
    }
    
    [self saveAddressToLocal];
}

- (void)updateWithProvinceId:(NSNumber *)aProvinceId
                provinceName:(NSString *)aProvinceName
                      cityId:(NSNumber *)aCityId
                    cityName:(NSString *)aCityName
                    countyId:(NSNumber *)aCountyId
                  countyName:(NSString *)aCountyName{
    self.currentProvinceId = aProvinceId;
    self.currentProvinceName = aProvinceName;
    self.currentCityId = aCityId;
    self.currentCityName = aCityName;
    self.currentCountyId = aCountyId;
    self.currentCountyName = aCountyName;
    
    [self saveAddressToLocal];
}

- (BOOL)isEqualToAddressWithProvinceId:(NSNumber *)aProvinceId
                                cityId:(NSNumber *)aCityId
                              countyId:(NSNumber *)aCountyId{
    BOOL ret = [self.currentProvinceId safeIsEqualToNumber:aProvinceId] && [self.currentCityId safeIsEqualToNumber:aCityId] && [self.currentCountyId safeIsEqualToNumber:aCountyId];
    return ret;
}

/**
 *  功能:获取省市区缓存文件路径
 */
+ (NSString *)allProvincesFilePathForCache{
    NSString *filePath = [[OTSFileManager appLibPath] stringByAppendingPathComponent:@"Caches/allOneStoreProvince.plist"];
    return filePath;
}

/**
 *  功能:获取省市区资源文件路径
 */
+ (NSString *)allProvincesFilePathForResource{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"allOneStoreProvince" ofType:@"plist"];
    return filePath;
}

/**
 *  功能:获取所有省市区
 *  返回:list<dictionary>
 */
+ (NSArray *)allProvincesArray{
    NSString *filePath = [self allProvincesFilePathForCache];
    NSArray *allProvincesArray = [NSArray arrayWithContentsOfFile:filePath];
    if (allProvincesArray.count == 0) {//如果因为网络原因导致请求省市区数据错误 就从本地bundle目录读取
        return [[self class] bundleAllProvincesArray];
    }
    return allProvincesArray;
}

+ (NSArray *)bundleAllProvincesArray{
    NSString *filePath = [self allProvincesFilePathForResource];
    NSArray *allProvincesArray = [NSArray arrayWithContentsOfFile:filePath];
    return allProvincesArray;
}

- (void)updateRaybuyAddressWithProvinceId:(NSNumber *)provinceId blockId:(NSNumber *)blockId cellId:(NSString *)cellId lat:(NSNumber *)lat lng:(NSNumber *)lng supportMerchant:(NSNumber *)supportMerchant displayAddress:(NSString *)displayAddress rayCity:(NSString *)rayCity receiverId:(NSNumber *)rayUserReceiverId{
    self.rayProvinceId = provinceId;
    self.blockId = blockId;
    self.cellId = cellId;
    self.lng = lng;
    self.lat = lat;
    self.supportMerchant = supportMerchant;
    self.displayAddress = displayAddress;
    self.rayCity = rayCity;
    self.rayUserReceiverId = rayUserReceiverId;
    [self saveAddressToLocal];
}

- (void)clearAllRayBuyInfo{
    self.rayUserReceiverId = nil;
    self.blockId = nil;
    self.cellId = nil;
    self.lng = nil;
    self.lat = nil;
    self.supportMerchant = nil;
    self.displayAddress = nil;
    self.rayCity = nil;
    self.rayProvinceId = nil;
    [self saveAddressToLocal];
}

@end
