//
//  BrandGrouponInterface.m
//  GrouponProject
//
//  Created by Vect Xi on 9/29/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "BrandGrouponInterface.h"
#import "GrouponBrandPage.h"

@implementation BrandGrouponInterface

/**
 *  获取品牌团列表
 *
 *  @param areaId
 *  @param categoryId
 *  @param page
 *  @param pageSize
 *  @param aCompletiobBlock
 *
 *  @retrun
 */
+ (OTSOperationParam *)getBrandGrouponListByAreaid:(NSInteger)areaId
                                        categoryId:(NSInteger)categoryId
                                       currentPage:(NSInteger)page
                                          pageSize:(NSInteger)pageSize
                                   completionBlock:(void(^)(GrouponBrandPage *page, NSError *error))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"categoryid": @(categoryId),
                             @"currentpage": @(page),
                             @"pagesize": @(pageSize)};
    OTSOperationParam *param
        = [OTSOperationParam paramWithBusinessName:@"groupon"
                                        methodName:@"getBrandGrouponList"
                                        versionNum:nil
                                              type:kRequestPost
                                             param:params
                                          callback:^(id aResponseObject, NSError *anError) {
                                              GrouponBrandPage *page = nil;
                                              if (!anError) {
                                                  NSError *error = nil;
                                                  page = [[GrouponBrandPage alloc] initWithDictionary:aResponseObject
                                                                                    error:&error];
                                                  
                                                  if (error) {
                                                      anError = error;
                                                      page = nil;
                                                  }
                                              }
                                              
                                              if (aCompletiobBlock) {
                                                  aCompletiobBlock(page, anError);
                                              }
                                          }];
    return param;
}

/**
 *  获取某品牌下的所有团购
 *
 *  @param areaId
 *  @param brandId
 *  @param sort
 *  @param page
 *  @param pageSize
 *  @param aCompletiobBlock
 *
 *  @return
 */
+ (OTSOperationParam *)getGrouponListByBrandId:(NSInteger)brandId
                                        areaId:(NSInteger)areaId
                                      sortType:(BrandGrouponSortType)sort
                                   currentPage:(NSInteger)page
                                      pageSize:(NSInteger)pageSize
                               completionBlock:(void(^)(GrouponPage *page, NSError *error))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"sorttype": @(sort),
                             @"grouponbrandid": @(brandId),
                             @"currentpage": @(page),
                             @"pagesize": @(pageSize)};
    OTSOperationParam *param
        = [OTSOperationParam paramWithBusinessName:@"groupon"
                                        methodName:@"getGrouponListByBrandId"
                                        versionNum:nil
                                              type:kRequestPost
                                             param:params
                                          callback:^(id aResponseObject, NSError *anError) {
                                              GrouponPage *page = nil;
                                              if (!anError) {
                                                  NSError *error = nil;
                                                  page = [[GrouponPage alloc] initWithDictionary:aResponseObject
                                                                                          error:&error];
                                                  
                                                  if (error) {
                                                      anError = error;
                                                      page = nil;
                                                  }
                                              }
                                              
                                              if (aCompletiobBlock) {
                                                  aCompletiobBlock(page, anError);
                                              }
                                          }];
    return param;
}

+ (OTSOperationParam *)getBrandGrouponById:(NSInteger)brandId
                                    areaId:(NSInteger)areaId
                           completionBlock:(void(^)(GrouponBrandVO *brandGroupon, NSError *error))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"brandid": @(brandId)};
    OTSOperationParam *param
        = [OTSOperationParam paramWithBusinessName:@"groupon"
                                        methodName:@"getBrandGrouponById"
                                        versionNum:nil
                                              type:kRequestPost
                                             param:params
                                          callback:^(id aResponseObject, NSError *anError) {
                                              GrouponBrandVO *brandVO = nil;
                                              if (!anError) {
                                                  NSError *error = nil;
                                                  brandVO = [[GrouponBrandVO alloc] initWithDictionary:aResponseObject error:&error];
                                                  if (error) {
                                                      anError = error;
                                                      brandVO = nil;
                                                  }
                                              }
                                              
                                              if (aCompletiobBlock) {
                                                  aCompletiobBlock(brandVO, anError);
                                              }
                                          }];
    return param;
}

@end
