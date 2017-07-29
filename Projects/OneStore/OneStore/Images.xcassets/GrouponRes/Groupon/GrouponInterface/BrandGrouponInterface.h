//
//  BrandGrouponInterface.h
//  GrouponProject
//
//  Created by Vect Xi on 9/29/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSNetworkInterface.h"
#import "GrouponBrandVO.h"
#import "GrouponVO.h"
#include "GrouponDefine.h"
#import "GrouponPage.h"
#import "GrouponBrandPage.h"

@interface BrandGrouponInterface : OTSNetworkInterface

/**
 *  获取某分类下的品牌团列表
 *
 *  @param areaId
 *  @param categoryId
 *  @param page
 *  @param pageSize
 *  @param aCompletiobBlock
 *
 *  @return  NSArray<GrouponBrandVO>
 */
+ (OTSOperationParam *)getBrandGrouponListByAreaid:(NSInteger)areaId
                                        categoryId:(NSInteger)categoryId
                                       currentPage:(NSInteger)page
                                          pageSize:(NSInteger)pageSize
                                   completionBlock:(void(^)(GrouponBrandPage *page, NSError *error))aCompletiobBlock;

/**
 *  获取某品牌下的团购列表
 *
 *  @param brandId
 *  @param areaId
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
                               completionBlock:(void(^)(GrouponPage *page, NSError *error))aCompletiobBlock;

/**
 *  获取品牌团详情
 *
 *  @param brandId
 *  @param areaId
 *  @param aCompletiobBlock
 *
 *  @return 
 */
+ (OTSOperationParam *)getBrandGrouponById:(NSInteger)brandId
                                    areaId:(NSInteger)areaId
                           completionBlock:(void(^)(GrouponBrandVO *brandGroupon, NSError *error))aCompletiobBlock;


@end
