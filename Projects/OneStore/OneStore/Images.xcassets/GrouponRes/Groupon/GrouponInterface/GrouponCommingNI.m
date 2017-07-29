//
//  GrouponCommingNI.m
//  GrouponProject
//
//  Created by Vect Xi on 11/8/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "GrouponCommingNI.h"

@implementation GrouponCommingNI

+ (OTSOperationParam *)commingDateParamByAreaId:(NSInteger)areaId
                                completionBlock:(void (^)(NSDictionary *dates))acompletionBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"groupon"
                                                             methodName:@"getBuildPreviewGroupon"
                                                             versionNum:nil
                                                                   type:kRequestPost
                                                                  param:@{@"areaid": @(areaId)}
                                                               callback:^(id aResponseObject, NSError *anError) {
                                                                   NSDictionary *dic = nil;
                                                                   if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]]) {
                                                                       dic = aResponseObject;
                                                                   }
                                                                   
                                                                   if (acompletionBlock) {
                                                                       acompletionBlock(dic);
                                                                   }
                                                               }];
    return param;
}

+ (OTSOperationParam *)commingGrouponParamByAreaId:(NSInteger)areaId
                                              date:(NSString *)date
                                       currentPage:(NSInteger)page
                                          pageSize:(NSInteger)pageSize
                                   completionBlock:(void(^)(GrouponCommingPage *page, NSError *error))aCompletionBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"date": date ? date : @"",
                             @"currentpage": @(page),
                             @"pagesize": @(pageSize)};
    OTSOperationParam *param
        = [OTSOperationParam paramWithBusinessName:@"groupon"
                                        methodName:@"getForecastGroupon"
                                        versionNum:nil
                                              type:kRequestPost
                                             param:params
                                          callback:^(id aResponseObject, NSError *anError) {
                                              GrouponCommingPage *page = nil;
                                              if (!anError) {
                                                  NSError *error = nil;
                                                  page = [[GrouponCommingPage alloc] initWithDictionary:aResponseObject
                                                                                                  error:&error];
                                                  
                                                  if (error) {
                                                      anError = error;
                                                      page = nil;
                                                  }
                                              }
                                              
                                              if (aCompletionBlock) {
                                                  aCompletionBlock(page, anError);
                                              }
                                          }];
    return param;
}

@end
