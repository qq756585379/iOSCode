//
//  OTSNICategory.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSNICategory.h"

@implementation OTSNICategory
/**
 * 功能点：获取1级分类数据
 */
+(OTSOperationParam *)getRootCategoryWithNavid:(NSNumber*)navid
                               completionBlock:(OTSCompletionBlock)aCompletionBlock {
    
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    [paramDict safeSetObject:navid forKey:@"navid"];
    [paramDict safeSetObject:@1 forKey:@"level"];
    
    OTSCompletionBlock resultCallBlcok = ^(id aResponseObject, NSError *anError) {
        aCompletionBlock(aResponseObject, anError);
    };
    OTSOperationParam *operationParam;
    operationParam = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                                   methodName:@"getNavigationCategory"
                                                   versionNum:nil
                                                         type:kRequestGet
                                                        param:paramDict
                                                     callback:resultCallBlcok];
    return operationParam;
}

/**
 * 功能点：获取2/3级分类数据
 */
+(OTSOperationParam *)getSubCategoryWithRootCateId:(NSNumber*)rootCateId
                                   completionBlock:(OTSCompletionBlock)aCompletionBlock {
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    [paramDict safeSetObject:rootCateId forKey:@"rootcateid"];
    [paramDict safeSetObject:@2 forKey:@"level"];
    
    OTSCompletionBlock resultCallBlcok = ^(id aResponseObject, NSError *anError) {
        aCompletionBlock(aResponseObject, anError);
    };
    OTSOperationParam *operationParam;
    operationParam = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                                   methodName:@"getNavigationCategory"
                                                   versionNum:nil
                                                         type:kRequestGet
                                                        param:paramDict
                                                     callback:resultCallBlcok];
    return operationParam;
    
}

/**
 * 功能点：广告getCategoryAdvertisementList
 *
 *getHotRecommendCateList
 */
+(OTSOperationParam *)getCategoryAdvertisementListWithRootCategoryId:(NSNumber*)rootCateId
                                                     completionBlock:(OTSCompletionBlock)aCompletionBlock{
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    [paramDict safeSetObject:rootCateId forKey:@"categoryid"];
    OTSCompletionBlock resultCallBlcok = ^(id aResponseObject, NSError *anError) {
        aCompletionBlock(aResponseObject, anError);
    };
    OTSOperationParam *operationParam = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                                                      methodName:@"getHotRecommendCateList"
                                                                      versionNum:nil
                                                                            type:kRequestGet
                                                                           param:paramDict
                                                                        callback:resultCallBlcok];
    return operationParam;
    
}

+(OTSOperationParam *)getMobSubCategorysById:(NSNumber*)rootId
                             completionBlock:(OTSCompletionBlock)aCompletionBlock {
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    [paramDict safeSetObject:rootId forKey:@"id"];
    OTSCompletionBlock resultCallBlcok = ^(id aResponseObject, NSError *anError) {
        aCompletionBlock(aResponseObject, anError);
    };
    OTSOperationParam *operationParam = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                                                      methodName:@"getMobSubCategorysById"
                                                                      versionNum:nil
                                                                            type:kRequestGet
                                                                           param:paramDict
                                                                        callback:resultCallBlcok];
    return operationParam;
}

+(OTSOperationParam *)getMobReCateList:(NSNumber*)rootId
                       completionBlock:(OTSCompletionBlock)aCompletionBlock {
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    [paramDict safeSetObject:rootId forKey:@"id"];
    OTSCompletionBlock resultCallBlcok = ^(id aResponseObject, NSError *anError) {
        aCompletionBlock(aResponseObject, anError);
    };
    OTSOperationParam *operationParam = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                                                      methodName:@"getMobReCateList"
                                                                      versionNum:nil
                                                                            type:kRequestGet
                                                                           param:paramDict
                                                                        callback:resultCallBlcok];
    return operationParam;
}

@end
