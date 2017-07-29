//
//  GrouponContainerVO.h
//  GrouponProject
//
//  Created by meichun on 14-10-13.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerVO.h"
#import "CmsColumnVO.h"

@interface GrouponContainerVO : ContainerVO



@property (nonatomic, strong) NSArray<HomePromotionDetailVO> *ads;  //List<HomePromotionDetailVO>	广告位

@property(nonatomic, copy) NSNumber *viewId;//团购预热，当前vo所在的ViewVO的nid
@property (nonatomic, strong) CmsColumnVO *cmsColumnVO;

#pragma mark - 团购预热本地提醒
/**
 *  功能:某商品(或团购)是否有当前栏目的提醒
 */
- (BOOL)haveGNativeNotificationForVO:(id)aVO;

/**
 *  功能:设置某商品(或团购)是否有当前栏目的提醒
 */
- (void)setHaveGNativeNotification:(BOOL)have withVO:(id)aVO;

@end
