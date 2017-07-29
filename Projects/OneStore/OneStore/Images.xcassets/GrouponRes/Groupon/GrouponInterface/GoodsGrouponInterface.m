//
//  GoodsGrouponInterface.m
//  GrouponProject
//
//  Created by zhangbin on 14-9-30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GoodsGrouponInterface.h"

@implementation GoodsGrouponInterface

+ (OTSOperationParam *)getGrouponListByCategoryid:(NSInteger)categoryid
                                        areaId:(NSInteger)areaId
                                      sortType:(BrandGrouponSortType)sort
                                   virtualtype:(GrouponVirtualType)virtualType
                                   currentPage:(NSInteger)page
                                      pageSize:(NSInteger)pageSize
                               completionBlock:(void(^)(GrouponGoodsPage *page, NSError *error))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"sorttype": @(sort),
                             @"categoryid": @(categoryid),
                             @"currentpage": @(page),
                             @"pagesize": @(pageSize),
                             @"virtualtype":@(virtualType)};
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"getCurrentGrouponList"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:params
                                      callback:^(id aResponseObject, NSError *anError) {
                                          GrouponGoodsPage *page = nil;
                                          if (!anError) {
                                              NSError *error = nil;
                                              page = [[GrouponGoodsPage alloc] initWithDictionary:aResponseObject error:&error];
                                           }
                                          
                                          if (aCompletiobBlock) {
                                              aCompletiobBlock(page, anError);
                                          }
                                      }];
    return param;
}

+ (OTSOperationParam *)createGrouponOrderBySerialid:(NSInteger)serialid
                                           areaId:(NSInteger)areaId
                                        grouponid:(NSInteger)grouponid
                                  completionBlock:(void(^)(GrouponOrderVO *aGrouponOrderVO, NSError *anError))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"serialid": @(serialid),
                             @"grouponid": @(grouponid),
                             @"appType":@(2)};
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"createGrouponOrder"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:params
                                      callback:^(id aResponseObject, NSError *anError) {
                                          GrouponOrderVO *grouponOrderVO = nil;
                                          if (!anError) {
                                              grouponOrderVO = [[GrouponOrderVO alloc] initWithDictionary:aResponseObject error:nil];
                                          }
                                          
                                          if (aCompletiobBlock) {
                                              aCompletiobBlock(grouponOrderVO, anError);
                                          }
                                      }];
    return param;
}

//2.	interface.m.yhd.com/groupon/submitGrouponOrder?areaid=1&grouponid=3308&serialid=0&grouponremarker=xxx&quantity=1&receiverid=222&paybyaccount=89&gatewayid=

+ (OTSOperationParam *)submitGrouponOrderWithSerialid:(NSInteger)serialid
                                               areaId:(NSInteger)areaId
                                            grouponid:(NSInteger)grouponid
                                             quantity:(NSInteger)quantity
                                           receiverid:(NSInteger)receiverid
                                            gatewayid:(NSInteger)gatewayid
                                      completionBlock:(void(^)(GrouponOrderSubmitResult *aGrouponOrderSubmitResult, NSError *anError))aCompletiobBlock
{
    NSDictionary *params = @{@"areaid": @(areaId),
                             @"serialid": @(serialid),
                             @"grouponid": @(grouponid),
                             @"quantity":@(quantity),
                             @"receiverid":@(receiverid),
                             @"gatewayid":@(gatewayid),
                             @"appType":@(2),
                             @"grouponremarker":@"",
                             @"paybyaccount":@(0.0)};
    OTSOperationParam *param
    = [OTSOperationParam paramWithBusinessName:@"groupon"
                                    methodName:@"submitGrouponOrder"
                                    versionNum:nil
                                          type:kRequestPost
                                         param:params
                                      callback:^(id aResponseObject, NSError *anError) {
                                          GrouponOrderSubmitResult *grouponOrderSubmitResult = nil;
                                          if (!anError) {
                                              grouponOrderSubmitResult = [[GrouponOrderSubmitResult alloc] initWithDictionary:aResponseObject error:nil];
                                          }
                                          
                                          if (aCompletiobBlock) {
                                              aCompletiobBlock(grouponOrderSubmitResult, anError);
                                          }
                                      }];
    return param;
}

@end
