//
//  GrouponInterface.m
//  GrouponProject
//
//  Created by meichun on 14-9-23.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponInterface.h"
#import "GrouponVO.h"
#import "GrouponWirelessStoreDto.h"
#import "Page.h"
#import "GrouponBrandVO.h"
#import "GrouponViewVO.h"
#import "HomePromotionDetailVO.h"
#import "GrouponContainerVO.h"
#import "OTSArchiveData.h"

static NSString *OTSClusterTagListCacheName = @"ClusterTagListCache.plist";
@interface GrouponInterface()

@property(nonatomic ,strong) NSString *BusinessName;

@end

@implementation GrouponInterface

/**
 *  功能:获取团购首页数据
 *
 *  @param aProvinceId:省份id
 *  @param aCompletionBlock:获取成功后的回调
 */
+ (OTSOperationParam *)getGrouponFlashIndexView:(NSNumber *)aProvinceId
                            withcompletionBlock:(OTSCompletionBlock)aCompletionBlock{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:aProvinceId forKey:@"provinceId"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                    methodName:@"getGrouponFlashIndexView"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              GrouponViewVO *viewVO = [[GrouponViewVO alloc] initWithDictionary:aResponseObject error:&anError];
                                              
                                              NSMutableArray *array = [[NSMutableArray alloc] init];
                                              if(viewVO.containers.count > 0){
                                                  for (NSDictionary *dic in viewVO.containers) {
                                                      GrouponContainerVO *vo = [[GrouponContainerVO alloc] initWithDictionary:dic error:&anError];
                                                      
                                                      [array safeAddObject:vo];
                                                  }
                                              }
                                              

                                             // TODO 缓存数据
                                              [OTSArchiveData archiveDataInDoc:array withFileName:OTSClusterTagListCacheName];
                                              aCompletionBlock(array, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}

/**
 * 根据省份Id取得区域Id
 */
+ (OTSOperationParam *)getAreaIdWithProvinceId:(long)provinceId
                               completionBlock:(OTSCompletionBlock)aCompletionBlock{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:@(provinceId) forKey:@"provinceId"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getGrouponAreaIdByProvinceId"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              NSNumber *theAreaId = aResponseObject;
                                              aCompletionBlock(theAreaId, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}

/**
 * 根据团购Id和区域Id获取一个团购的详情
 * grouponId 团购id
 * areaId 区域id
 */
+ (OTSOperationParam *)getGrouponDetailWithId:(long)grouponId
                                       areaId:(long)areaId
                              completionBlock:(OTSCompletionBlock)aCompletionBlock{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:@(grouponId) forKey:@"grouponId"];
    [mDict safeSetObject:@(areaId) forKey:@"areaId"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getGrouponDetail"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              GrouponVO *vo = [[GrouponVO alloc] initWithDictionary:aResponseObject error:&anError];
                                              aCompletionBlock(vo, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}

/**
 * 获取店铺的信息
 */
+ (OTSOperationParam *)getStoreInfoWithMerchantId:(NSNumber *)merchantId
                        provinceId:(NSNumber *)provinceId
                        completion:(OTSCompletionBlock)aCompletionBlock
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:merchantId forKey:@"merchantid"];
    [mDict safeSetObject:provinceId forKey:@"proviceid"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"store"
                                    methodName:@"getStoreInfo"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              GrouponWirelessStoreDto *vo = [[GrouponWirelessStoreDto alloc] initWithDictionary:aResponseObject error:&anError];
                                              aCompletionBlock(vo, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}

/*
 * 分页获取品牌团下得团购
 */
+ (OTSOperationParam *)getBrandGrouponProductListByBrandGrouponID:(NSNumber*)aBrandGrouponID
                                                           areaId:(long)areaId
                                                         sortType:(int)sorType
                                                      currentPage:(int)currentPage
                                                         pageSize:(int)pageSize
                                                  completionBlock:(OTSCompletionBlock)aCompletionBlock{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:aBrandGrouponID forKey:@"grouponbrandid"];
    [mDict safeSetObject:@(areaId) forKey:@"areaId"];
    [mDict safeSetObject:@(sorType) forKey:@"sorType"];
    [mDict safeSetObject:@(currentPage) forKey:@"currentPage"];
    [mDict safeSetObject:@(pageSize) forKey:@"pageSize"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getGrouponListByBrandId"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              Page *page = [[Page alloc] initWithDictionary:aResponseObject error:&anError];
                                              
                                              if(page.objList.count > 0){
                                                  NSMutableArray *array = [[NSMutableArray alloc] init];
                                                  for (NSDictionary *dic in page.objList) {
                                                      GrouponVO *vo = [[GrouponVO alloc] initWithDictionary:dic error:&anError];
                                                      [array safeAddObject:vo];
                                                  }
                                                  page.objList = array;
                                              }
                                              
                                              aCompletionBlock(page, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}

/*
 * 根据品牌团id获取品牌团的信息
 */
+ (OTSOperationParam *)getBrandById:(NSNumber *)brandId
                             areaId:(long)areaId
                    completionBlock:(OTSCompletionBlock)aCompletionBlock
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:brandId forKey:@"brandId"];
    [mDict safeSetObject:@(areaId) forKey:@"areaId"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getBrandGrouponById"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          if (!anError) {
                                              GrouponBrandVO *vo = [[GrouponBrandVO alloc] initWithDictionary:aResponseObject error:&anError];
                                              aCompletionBlock(vo, anError);
                                          } else {
                                              if(aCompletionBlock){
                                                  aCompletionBlock(aResponseObject, anError);
                                              }
                                          }
                                      }];
    
    return param;
}


+ (OTSOperationParam *)getGrouponCategoryList:(NSInteger)areaId
                                  virtualtype:(GrouponVirtualType)virtualType
                                   objecttype:(GrouponObjectType)objectType
                              completionBlock:(void (^)(NSArray *, NSError *))aCompletionBlock
{
    
    
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"virtualtype": @(virtualType),
                             @"objecttype": @(objectType)};
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getGrouponCategoryList"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:params
                                      callback:^(id aResponseObject, NSError *anError) {
                                          NSMutableArray *categories = [NSMutableArray array];
                                          if (!anError) {
                                              NSError *error = nil;
                                              for (NSDictionary *obj in aResponseObject) {
                                                  GrouponCategoryVO *category = [[GrouponCategoryVO alloc] initWithDictionary:obj error:&error];
                                                  [categories safeAddObject:category];
                                              }
                                              
                                              if (error) {
                                                  [categories removeAllObjects];
                                                  categories = nil;
                                              }
                                              
                                              anError = error;
                                          }
                                          
                                          if (aCompletionBlock) {
                                              aCompletionBlock(categories, anError);
                                          }
                                      }];
    return param;
}

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
                          completionBlock:(void(^)(CmsColumnVO *cmsColumnVO, NSError *error))aCompletionBlock
{

    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:cmsColumnId forKey:@"cmsColumnId"];
    [mDict safeSetObject:@(sortType) forKey:@"sortType"];
    [mDict safeSetObject:@(currentPage) forKey:@"currentPage"];
    [mDict safeSetObject:@(pageSize) forKey:@"pageSize"];

    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"mobileservice"
                                    methodName:@"getCmsColumnDetail"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          CmsColumnVO *cmsColumnVO = [CmsColumnVO alloc];
                                          NSError *error = nil;
                                          if (!anError) {
                                            cmsColumnVO = [[CmsColumnVO alloc] initWithDictionary:aResponseObject error:&error];
                                            anError = error;
                                          }
                                          
                                          if (aCompletionBlock) {
                                              aCompletionBlock(cmsColumnVO, anError);
                                          }
                                      }];
    return param;
}

/**
 * 创建团购订单
 *
 */
+(OTSOperationParam *)createGrouponOrderWithGrouponVO:(GrouponVO *) grouponVO
                                               areaId:(NSInteger)areaId
                                      completionBlock:(void(^)(GrouponOrderVO *grouponOrderVO, NSError *error))aCompletionBlock
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict safeSetObject:@(areaId) forKey:@"areaid"];
    [mDict safeSetObject:grouponVO.nid forKey:@"grouponid"];
    [mDict safeSetObject:grouponVO.grouponSerialVO.nid forKey:@"serialid"];
    [mDict safeSetObject:@(2) forKey:@"apptype"];
    
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"createGrouponOrder"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:mDict
                                      callback:^(id aResponseObject, NSError *anError) {
                                          GrouponOrderVO *grouponOrderVO = [GrouponOrderVO alloc];
                                          NSError *error = nil;
                                          if (!anError) {
                                              grouponOrderVO = [[GrouponOrderVO alloc] initWithDictionary:aResponseObject error:&error];
                                              anError = error;
                                          }
                                          
                                          if (aCompletionBlock) {
                                              aCompletionBlock(grouponOrderVO, anError);
                                          }
                                      }];
    return param;
}

@end
