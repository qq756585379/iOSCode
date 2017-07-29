//
//  GrouponContainerVO.m
//  GrouponProject
//
//  Created by meichun on 14-10-13.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponContainerVO.h"
#import "GrouponProductVO.h"
#import "GrouponVO.h"

@implementation GrouponContainerVO

#pragma mark - 团购预热本地提醒
/**
 *  功能:某商品(或团购)是否有当前栏目的提醒
 */
- (BOOL)haveGNativeNotificationForVO:(id)aVO
{
#ifndef APP_EXTENSIONS
    HomePromotionDetailVO *detailVO = [self.ads safeObjectAtIndex:0];
    NSString *notifiName = [NSString stringWithFormat:@"%@ %@[商品]英雄团%@", self.startTime, detailVO.promotionId, self.viewId];
    UILocalNotification *localNotification = [OTSLocalNotification findLocalNotificationWithName:notifiName];
    
    BOOL have = NO;
    id userInfo = localNotification.userInfo;
    if ([userInfo isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *mDict = userInfo;
        id obj = nil;
        if ([aVO isKindOfClass:[GrouponProductVO class]]) {
            obj = [mDict safeObjectForKey:((GrouponProductVO*)aVO).productId.stringValue];
        }
//        else if([aVO isKindOfClass:[ProductDetailVO class]]){
//            obj = [mDict safeObjectForKey:((ProductDetailVO*)aVO).productId.stringValue];
//        }
        else if ([aVO isKindOfClass:[GrouponVO class]]) {
            obj = [mDict safeObjectForKey:((GrouponVO*)aVO).nid.stringValue];
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            have = [obj boolValue];
        }
    }
    
    return have;
#else
    return NO;
#endif
}

/**
 *  功能:设置某商品(或团购)是否有当前栏目的提醒
 */
- (void)setHaveGNativeNotification:(BOOL)have withVO:(id)aVO
{
//    if ([aVO isKindOfClass:[GrouponProductVO class]]) {
//        NSArray *productArray = self.cmsColumnVO.productPage.objList;
//        for (GrouponProductVO *productVO in productArray) {
//            if ([productVO.productId isEqualToNumber:[(GrouponProductVO*)aVO productId]]) {
//                productVO.remind = have;
//                break;
//            }
//        }
//    }
//    else if ([aVO isKindOfClass:[ProductDetailVO class]]){
//        NSArray *productArray = self.cmsColumnVO.productPage.objList;
//        for (ProductVO *productVO in productArray) {
//            if ([productVO.productId isEqualToNumber:[(ProductDetailVO*)aVO productId]]) {
//                productVO.remind = have;
//                break;
//            }
//        }
//    }
//    else if ([aVO isKindOfClass:[GrouponVO class]]) {
        NSArray *grouponArray = self.cmsColumnVO.grouponVOPage.objList;
        for (GrouponVO *grouponVO in grouponArray) {
            if ([grouponVO.nid isEqualToNumber:[(GrouponVO*)aVO nid]]) {
                grouponVO.remind = have;
                break;
            }
        }
//    }
#ifndef APP_EXTENSIONS
    HomePromotionDetailVO *detailVO = [self.ads safeObjectAtIndex:0];
    NSString *notifiName = [NSString stringWithFormat:@"%@ %@[商品]英雄团%@", self.startTime, detailVO.promotionId, self.viewId];
    UILocalNotification *localNotification = [OTSLocalNotification findLocalNotificationWithName:notifiName];
    
    NSInteger remindCount = [self remindCount];
    if (remindCount <= 0) {//当前活动没有订阅
        if (localNotification != nil) {//本地有提醒则取消提醒
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    } else {//当前活动有订阅
        //取消本地提醒
        [OTSLocalNotification cancelLocalNotificationWithName:notifiName];
        //创建本地提醒
        NSString *title = [self remindTitle];
        
        NSString *dateStr = self.startTime;
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *serverDate = [formater dateFromString:dateStr];
        NSDate *localDate = [NSDate dateWithTimeInterval:[OTSGlobalValue sharedInstance].dTime sinceDate:serverDate];
//        NSMutableDictionary *userInfo = [self remindDict];
        
        NSString *uri = [NSString getRouterVCUrlStringFromUrlString:GrouponDetailKey
                                                          andParams:@{@"grouponid": [(GrouponVO*)aVO nid]}];
        
        [OTSLocalNotification createLocalNotificationWithName:notifiName withTitle:title withFireDate:localDate routerUrl:uri];
    }
#endif
}

/**
 *  功能:获取当前栏目下所有提醒的数量
 */
- (NSInteger)remindCount
{
    NSInteger count = 0;
    NSArray *grouponArray = self.cmsColumnVO.grouponVOPage.objList;
    NSArray *productArray = self.cmsColumnVO.productPage.objList;
    for (GrouponVO *grouponVO in grouponArray) {
        if (grouponVO.remind) {
            count ++;
        }
    }
    for (GrouponProductVO *productVO in productArray) {
        if (productVO.remind) {
            count ++;
        }
    }
    
    return count;
}

/**
 *  功能:获取当前栏目下提醒的标题
 */
- (NSString *)remindTitle
{
    NSInteger count = 0;
    NSString *title;
    NSArray *grouponArray = self.cmsColumnVO.grouponVOPage.objList;
    NSArray *productArray = self.cmsColumnVO.productPage.objList;
    for (GrouponVO *grouponVO in grouponArray) {
        if (grouponVO.remind) {
            if (count == 0) {
                title = [NSString stringWithFormat:@"1号团购[%@]开卖啦! 现在去看看?", grouponVO.name];
            } else {
                title = [NSString stringWithFormat:@"1号团购[%@]等开卖啦! 现在去看看?", grouponVO.name];
                return title;
            }
            
            count ++;
        }
    }
    for (GrouponProductVO *productVO in productArray) {
        if (productVO.remind) {
            if (count == 0) {
                title = [NSString stringWithFormat:@"1号团购[%@]开卖啦! 现在去看看?", productVO.cnName];
            } else {
                title = [NSString stringWithFormat:@"1号团购[%@]等开卖啦! 现在去看看?", productVO.cnName];
                return title;
            }
            
            count ++;
        }
    }
    
    return title;
}

/**
 *  功能:获取当前栏目下提醒信息
 */
- (NSMutableDictionary *)remindDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *grouponArray = self.cmsColumnVO.grouponVOPage.objList;
    NSArray *productArray = self.cmsColumnVO.productPage.objList;
    for (GrouponVO *grouponVO in grouponArray) {
        if (grouponVO.remind) {
            [dict safeSetObject:@(YES) forKey:grouponVO.nid.stringValue];
        }
    }
    for (GrouponProductVO *productVO in productArray) {
        if (productVO.remind) {
            [dict safeSetObject:@(YES) forKey:productVO.productId.stringValue];
        }
    }
    
    return dict;
}



@end
