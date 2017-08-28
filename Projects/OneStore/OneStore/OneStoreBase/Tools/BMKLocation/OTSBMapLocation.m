//
//  OTSBMapLocation.m
//  OneStoreBase
//
//  Created by Eason Qian on 15/10/30.
//  Copyright © 2015年 OneStoreBase. All rights reserved.
//

#import "OTSBMapLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"
#import "OTSLog.h"
#import "OTSBIGlobalValue.h"

@interface OTSBMapLocation ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) OTSBMKLocationCompleteBlock block;
@end

@implementation OTSBMapLocation

- (id)init{
    if (self = [super init]) {
        [self setupCL];
    }
    return self;
}

- (void)dealloc{
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}

- (void)setupCL{
    [BMKLocationService setLocationDistanceFilter:100.f];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    
    self.locService =[BMKLocationService new];
    self.locService.delegate = self;
    
    self.geocodesearch = [BMKGeoCodeSearch new];
    self.geocodesearch.delegate = self;
}

- (void)start{
    if (self.locService) {
        [self.locService startUserLocationService];
    }else {
        [self locationWithIp];
    }
}

- (void)locationWithIp{
    [self locationWithCLLocation:nil];
}

- (void)locationWithCLLocation:(CLLocation *)aLocation{
    [self locationWithCLLocation:aLocation andPlacemarkDict:nil];
}

- (void)locationWithCLLocation:(CLLocation *)aLocation andPlacemarkDict:(NSDictionary *)addressDictionary{
    if (self.block) {
        self.block(addressDictionary, aLocation);
    }
}

- (void)startWithCompleteBlock:(OTSBMKLocationCompleteBlock)block{
    self.block = block;
    [self start];
}

- (void)stop{
    [self.locService stopUserLocationService];
    self.block = nil;
}

//通过定位信息获取城市信息
- (void)locationToCityName:(CLLocation *)aLocation{
    static int count =0;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = aLocation.coordinate;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag) {
        NSLog(@"反geo检索发送成功");
        [self.locService stopUserLocationService];
    }else {
        NSLog(@"反geo检索发送失败");
        if (count >= 5) {
            count = 0;
            [self.locService stopUserLocationService];
            return;
        }
        count++;
    }
}

#pragma mark - 百度地图
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    OTSLogE(@"userLocation ＝ %@",userLocation);

//    NSString *latitude = [NSString stringWithFormat:@"30.483148"];//武汉1号店经纬度
//    NSDecimalNumber *laNum = [NSDecimalNumber decimalNumberWithString:latitude];
//    NSString *longtitude = [NSString stringWithFormat:@"114.414723"];
//    NSDecimalNumber *loNum = [NSDecimalNumber decimalNumberWithString:longtitude];
//    CLLocation *alocation = [[CLLocation alloc]initWithLatitude:[laNum doubleValue] longitude:[loNum doubleValue]];
//    self.location = alocation;
//    [self locationToCityName:alocation];
    self.location = userLocation.location;
    [self locationToCityName:userLocation.location];
}

/**
 *  功能
 *
 *  @param error
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    [self locationWithIp];
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error!=0) {
        NSLog(@"error = %d",error);
        [self locationWithCLLocation:self.location];
    }else {
        NSMutableDictionary *addressDictionary = @{}.mutableCopy;
        OTSLogE(@"error = %d",error);
        OTSLogE(@"province = %@",result.addressDetail.province);
        OTSLogE(@"city = %@",result.addressDetail.city);
        OTSLogE(@"district = %@",result.addressDetail.district);
        OTSLogE(@"streetName = %@",result.addressDetail.streetName);
        OTSLogE(@"streetNumber = %@",result.addressDetail.streetNumber);
        // 大量定位信息的tracker埋点
        addressDictionary[@"Province"] = result.addressDetail.province;
        addressDictionary[@"City"] = result.addressDetail.city;
        addressDictionary[@"District"] = result.addressDetail.district;
        addressDictionary[@"StreetName"] = result.addressDetail.streetName;
        addressDictionary[@"StreetNumber"] = result.addressDetail.streetNumber;
        if (result.addressDetail.province && result.addressDetail.city && result.addressDetail.district && result.addressDetail.streetName && result.addressDetail.streetNumber){
            [OTSBIGlobalValue sharedInstance].locationInfo = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
            [OTSBIGlobalValue sharedInstance].proviceInfo = addressDictionary[@"Province"];
            [OTSBIGlobalValue sharedInstance].cityInfo = addressDictionary[@"City"];
        }
        [self locationWithCLLocation:self.location andPlacemarkDict:addressDictionary];
    }
}

@end
