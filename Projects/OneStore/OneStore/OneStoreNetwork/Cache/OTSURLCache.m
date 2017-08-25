//
//  OTSURLCache.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSURLCache.h"
#import "OTSFileManager.h"
#import "OTSCurrentAddress.h"

static NSString * const CustomURLCacheExpirationKey = @"CustomURLCacheExpiration";
static NSString * const CustomURLCacheTimeKey = @"CustomURLCacheTimeKey";
static NSTimeInterval const CustomURLCacheExpirationInterval = 0;

@interface OTSURLCache()
@property(nonatomic, strong) NSMutableDictionary *interfaceCacheDict;//记录接口最新版本号及更新比对时间，比这个时间更早的接口需要删除缓存
@end

@implementation OTSURLCache

+ (instancetype)standardURLCache{
    static OTSURLCache *_standardURLCache = nil;
    static dispatch_once_t onceTokenInCache;
    dispatch_once(&onceTokenInCache, ^{
        _standardURLCache = [[OTSURLCache alloc] initWithMemoryCapacity:(6 * 1024 * 1024) diskCapacity:(50 * 1024 * 1024) diskPath:nil];
    });
    return _standardURLCache;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)aRequest{
    NSURLRequest *modifiedRequest = [self getModifiedRequest:aRequest];

    NSCachedURLResponse *cachedResponse = [super cachedResponseForRequest:modifiedRequest];
    
    if (cachedResponse) {
        //超过缓存时间，删除缓存
        NSString *cacheTime = [aRequest valueForHTTPHeaderField:@"Cache-control"];
        if ([cacheTime hasPrefix:@"max-age="]) {
            cacheTime = [cacheTime safeSubstringFromIndex:8];
        }
        NSTimeInterval cacheExpireInterval = [cacheTime doubleValue];
        if (cacheExpireInterval > 0.0) {
        } else {
            cacheExpireInterval = CustomURLCacheExpirationInterval;
        }
        NSDate *dateWhenCache = cachedResponse.userInfo[CustomURLCacheExpirationKey];//做缓存时的时间
        NSDate *cacheExpireDate = [dateWhenCache dateByAddingTimeInterval:cacheExpireInterval];
        NSDate *currentDate = [NSDate date];
        if ([cacheExpireDate compare:currentDate] == NSOrderedAscending) {
            [self removeCachedResponseForRequest:aRequest];
            return nil;
        }
        
        //比"更新比对时间"更早，删除缓存
        NSString *requestUrlStr = aRequest.URL.absoluteString;
        NSArray *componentArray = [requestUrlStr componentsSeparatedByString:@"?"];
        NSString *headStr = [componentArray safeObjectAtIndex:0];
        NSArray *allKeys = self.interfaceCacheDict.allKeys.copy;
        for (NSString *key in allKeys) {
            if ([headStr safeRangeOfString:key].location != NSNotFound) {
                NSDate *compareTime = self.interfaceCacheDict[key][@"compareTime"];
                if ([dateWhenCache compare:compareTime] == NSOrderedAscending) {
                    [self removeCachedResponseForRequest:aRequest];
                    return nil;
                }
            }
        }
    }
    return cachedResponse;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)aRequest{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:cachedResponse.userInfo];
    userInfo[CustomURLCacheExpirationKey] = [NSDate date];
    NSString *cacheTime = [aRequest valueForHTTPHeaderField:@"Cache-control"];
    if (cacheTime==nil || [cacheTime isEqualToString:@"max-age=0"]) {
        return;
    }
    userInfo[CustomURLCacheTimeKey] = cacheTime;
    
    NSCachedURLResponse *modifiedCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:userInfo storagePolicy:cachedResponse.storagePolicy];
    
    NSURLRequest *modifiedRequest = [self getModifiedRequest:aRequest];
    [super storeCachedResponse:modifiedCachedResponse forRequest:modifiedRequest];
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request{
    NSURLRequest *modifiedRequest = [self getModifiedRequest:request];
    [super removeCachedResponseForRequest:modifiedRequest];
}

#pragma mark - API
/**
 *  功能:根据最新的接口版本号进行处理
 *  param:dict，格式{methodName:version}
 */
- (void)dealWithNewInterfaceVersionDict:(NSDictionary *)versionDict{
    [self performInThreadBlock:^{
        NSArray *allKeys = versionDict.allKeys.copy;
        BOOL changed = NO;
        for (NSString *key in allKeys) {
            NSNumber *newVersion = versionDict[key];
            NSNumber *currentVersion = self.interfaceCacheDict[key][@"version"];
            if (![newVersion safeIsEqualToNumber:currentVersion]) {
                changed = YES;
                NSMutableDictionary *mDict = @{}.mutableCopy;
                mDict[@"version"] = newVersion;
                mDict[@"compareTime"] = [NSDate date];
                self.interfaceCacheDict[key] = mDict;
            }
        }
        //存储最新接口版本dict
        if (changed) {
            [self.interfaceCacheDict writeToFile:[[OTSFileManager appLibPath] stringByAppendingPathComponent:@"Caches/interfaceCacheDict.plist"] atomically:YES];
        }
    }];
}

#pragma mark - Inner
/**
 *  功能:获取经过处理的request，把参数中跟签名、时间戳相关的参数及trader去掉，在后面加上省份id
 *  aRequest:原request
 *  返回:经过处理的request
 */
- (NSURLRequest *)getModifiedRequest:(NSURLRequest *)aRequest{
    NSString *requestUrlStr = aRequest.URL.absoluteString;
    NSString *modifiedUrlStr;
    NSArray *componentArray = [requestUrlStr componentsSeparatedByString:@"?"];
    if (componentArray.count > 1) {
        NSString *headStr = [componentArray safeObjectAtIndex:0];
        NSString *queryUrl = [componentArray lastObject];
        NSArray *paramArray = [queryUrl componentsSeparatedByString:@"&"];
        NSMutableArray *modifiedParamArray = [@[] mutableCopy];
        for (NSString *paramStr in paramArray) {
            if (![paramStr hasPrefix:@"signature="] &&
                ![paramStr hasPrefix:@"signature_method="] &&
                ![paramStr hasPrefix:@"timestamp="] &&
                ![paramStr hasPrefix:@"trader=iosSystem"]) {
                [modifiedParamArray safeAddObject:paramStr];
            }
        }
        NSString *modifiedParamStr = [modifiedParamArray componentsJoinedByString:@"&"];
        
        if (modifiedParamStr.length > 0) {
            modifiedUrlStr = [NSString stringWithFormat:@"%@?%@&provinceId=%@", headStr, modifiedParamStr, [OTSCurrentAddress sharedInstance].currentProvinceId];
        } else {
            modifiedUrlStr = [NSString stringWithFormat:@"%@?provinceId=%@", headStr, [OTSCurrentAddress sharedInstance].currentProvinceId];
        }
    } else {
        modifiedUrlStr = requestUrlStr;
    }
    
    NSMutableURLRequest *modifiedRequest = [aRequest mutableCopy];
    modifiedRequest.URL = [NSURL URLWithString:modifiedUrlStr];
    return modifiedRequest;
}

#pragma mark - Property
- (NSMutableDictionary *)interfaceCacheDict{
    if (_interfaceCacheDict == nil) {
        _interfaceCacheDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[OTSFileManager appLibPath] stringByAppendingPathComponent:@"Caches/interfaceCacheDict.plist"]];
        if (_interfaceCacheDict == nil) {
            _interfaceCacheDict = @{}.mutableCopy;
        }
    }
    return _interfaceCacheDict;
}

@end
