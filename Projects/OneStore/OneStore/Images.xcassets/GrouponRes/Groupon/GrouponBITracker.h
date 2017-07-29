//
//  GrouponBITracker.h
//  GrouponProject
//
//  Created by Vect Xi on 11/14/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSBITracker.h"

/**
 *  号团团购首页
 */
UIKIT_EXTERN NSString *const GrouponHomeBI_ID;
/**
 *  团购商品列表页
 */
UIKIT_EXTERN NSString *const GrouponProductListBI_ID;
/**
 *  团购商品详情
 */
UIKIT_EXTERN NSString *const GrouponProductDetailBI_ID;
/**
 *  今日上新列表页
 */
UIKIT_EXTERN NSString *const GrouponTodayProductListBI_ID;
/**
 *  团购即将开团列表页
 */
UIKIT_EXTERN NSString *const GrouponCommingBI_ID;
/**
 *  品牌团首页
 */
UIKIT_EXTERN NSString *const GrouponBrandHomeBI_ID;
/**
 *  品牌团分类页
 */
UIKIT_EXTERN NSString *const GrouponBrandCategoryBI_ID;
/**
 *  品牌团品牌详情
 */
UIKIT_EXTERN NSString *const GrouponBrandDetailBI_ID;
/**
 *  团购属性选择
 */
UIKIT_EXTERN NSString *const GrouponProductSeriealsBI_ID;
/**
 *  团购一键购订单确认
 */
UIKIT_EXTERN NSString *const GrouponCheckOrderBI_ID;

@interface GrouponBITracker : OTSBITracker

+ (void)sendTracker:(OTSBITrackerBDPramaVO *)tracker;

+ (OTSBITrackerBDPramaVO *)trackerparamWithPageId:(NSString *)pageId;

+ (OTSBITrackerBDPramaVO *)trackerparamWithPageId:(NSString *)pageId
                                              tpa:(NSString *)tpa
                                              tpi:(NSString *)tpi;

@end
