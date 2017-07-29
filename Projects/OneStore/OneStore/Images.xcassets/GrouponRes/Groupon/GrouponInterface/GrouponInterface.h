//
//  GrouponInterface.h
//  GrouponProject
//
//  Created by meichun on 14-9-23.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponCategoryVO.h"
#import "OTSNetworkInterface.h"
#include "GrouponDefine.h"
#import "CmsColumnVO.h"
#import "GrouponVO.h"
#import "GrouponOrderVO.h"

@interface GrouponInterface : OTSNetworkInterface

/**
 *  功能:获取团购首页数据
 *
 *  @param aProvinceId:省份id
 *  @param aCompletionBlock:获取成功后的回调
 */
+ (OTSOperationParam *)getGrouponFlashIndexView:(NSNumber *)aProvinceId
                            withcompletionBlock:(OTSCompletionBlock)aCompletionBlock;


/**
 */
+ (OTSOperationParam *)getAreaIdWithProvinceId:(long)provinceId
                              completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 根据团购Id和区域Id获取一个团购的详情
 * grouponId 团购id
 * areaId 区域id
 */
+ (OTSOperationParam *)getGrouponDetailWithId:(long)grouponId
                                 areaId:(long)areaId
                     completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 获取店铺的信息
 */
+ (OTSOperationParam *)getStoreInfoWithMerchantId:(NSNumber *)merchantId
                        provinceId:(NSNumber *)provinceId
                        completion:(OTSCompletionBlock)aCompletionBlock;

/*
 * 分页获取品牌团下得团购
 */
+ (OTSOperationParam *)getBrandGrouponProductListByBrandGrouponID:(NSNumber*)aBrandGrouponID
                                                           areaId:(long)areaId
                                                         sortType:(int)sortType
                                                      currentPage:(int)currentPage
                                                         pageSize:(int)pageSize
                                                  completionBlock:(OTSCompletionBlock)aCompletionBlock;

/*
 * 根据品牌团id获取品牌团的信息
 */
+ (OTSOperationParam *)getBrandById:(NSNumber *)brandId
                    areaId:(long)areaId
                    completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 *  获取团购分类
 *
 *  @param areaId
 *  @param virtualType
 *  @param objectType
 *  @param aCompletionBlock
 *
 *  @return NSArray<GrouponCategoryVO>
 */
+ (OTSOperationParam *)getGrouponCategoryList:(NSInteger)areaId
                                  virtualtype:(GrouponVirtualType)virtualType
                                   objecttype:(GrouponObjectType)objectType
                              completionBlock:(void(^)(NSArray *categories, NSError *error))aCompletionBlock;

/**
 *  获取CMS栏目详情
 *
 *
 *  @return CmsColumnVO
 */
+ (OTSOperationParam *)getCmsColumnDetail:(NSNumber *)cmsColumnId
                                   sortType:(int)sortType
                                 currentPage:(int)currentPage
                                 pageSize:(int)pageSize
                              completionBlock:(void(^)(CmsColumnVO *cmsColumnVO, NSError *error))aCompletionBlock;

/**
 * 创建团购订单
 *
 */
+(OTSOperationParam *)createGrouponOrderWithGrouponVO:(GrouponVO *) grouponVO
                                               areaId:(NSInteger)areaId
                                      completionBlock:(void(^)(GrouponOrderVO *grouponOrderVO, NSError *error))aCompletionBlock;

@end
