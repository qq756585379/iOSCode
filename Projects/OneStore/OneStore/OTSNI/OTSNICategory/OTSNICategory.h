//
//  OTSNICategory.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSNetworkInterface.h"
#import "OTSOperationParam.h"

@interface OTSNICategory : OTSNetworkInterface
/**
 * 功能点：获取1级分类数据
 */
+(OTSOperationParam *)getRootCategoryWithNavid:(NSNumber*)navid
                               completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：获取2/3级分类数据
 */
+(OTSOperationParam *)getSubCategoryWithRootCateId:(NSNumber*)rootCateId
                                   completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：广告
 */
+(OTSOperationParam *)getCategoryAdvertisementListWithRootCategoryId:(NSNumber*)rootCateId
                                                     completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：通过2级前台类目获取其下的子类目
 */
+(OTSOperationParam *)getMobSubCategorysById:(NSNumber*)rootId
                             completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：通过 rootId 获取热门推荐下的三级类目
 */
+(OTSOperationParam *)getMobReCateList:(NSNumber*)rootId
                       completionBlock:(OTSCompletionBlock)aCompletionBlock;
@end
