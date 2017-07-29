//
//  GoodsGrouponInterface.h
//  GrouponProject
//
//  Created by zhangbin on 14-9-30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GrouponDefine.h"
#import "GrouponVO.h"
#import "GrouponGoodsPage.h"
#import "GrouponOrderVO.h"
#import "GrouponOrderSubmitResult.h"

@interface GoodsGrouponInterface : NSObject

/**
 *  获取团购列表
 *
 *  @param categoryid       分类id -1为全部
 *  @param areaId           区域id
 *  @param sort             排序方式
 *  @param virtualType      普通还是品牌团
 *  @param page             当前page
 *  @param pageSize         每页大小
 *  @param aCompletiobBlock
 *
 *  @return OTSOperationParam
 */
+ (OTSOperationParam *)getGrouponListByCategoryid:(NSInteger)categoryid
                                           areaId:(NSInteger)areaId
                                         sortType:(BrandGrouponSortType)sort
                                      virtualtype:(GrouponVirtualType)virtualType
                                      currentPage:(NSInteger)page
                                         pageSize:(NSInteger)pageSize
                                  completionBlock:(void(^)(GrouponGoodsPage *page, NSError *error))aCompletiobBlock;

/**
 *  创建团购订单
 *
 *  @param serialid         属性id
 *  @param areaId           区域id
 *  @param grouponid        团购号
 *  @param aCompletiobBlock aCompletiobBlock
 *
 *  @return OTSOperationParam
 */
+ (OTSOperationParam *)createGrouponOrderBySerialid:(NSInteger)serialid
                                             areaId:(NSInteger)areaId
                                          grouponid:(NSInteger)grouponid
                                    completionBlock:(void(^)(GrouponOrderVO *aGrouponOrderVO, NSError *anError))aCompletiobBlock;

/**
 *  提交团购订单
 *
 *  @param serialid         属性id
 *  @param areaId           区域id
 *  @param grouponid        团购号
 *  @param quantity         数量
 *  @param receiverid       地址
 *  @param gatewayid        网关id
 *  @param aCompletiobBlock aCompletiobBlock
 *
 *  @return OTSOperationParam
 */
+ (OTSOperationParam *)submitGrouponOrderWithSerialid:(NSInteger)serialid
                                               areaId:(NSInteger)areaId
                                            grouponid:(NSInteger)grouponid
                                             quantity:(NSInteger)quantity
                                           receiverid:(NSInteger)receiverid
                                            gatewayid:(NSInteger)gatewayid
                                      completionBlock:(void(^)(GrouponOrderSubmitResult *aGrouponOrderSubmitResult, NSError *anError))aCompletiobBlock;

@end
