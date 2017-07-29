//
//  WirelessStoreDto.h
//  OneStore
//
//  Created by 江 立 on 13-9-13.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponMerchantRateCommentary.h"
#import "GrouponMerchantInfoVO.h"

@interface GrouponWirelessStoreDto : OTSValueObject

@property(nonatomic ,strong) NSNumber *nid;/** ID */
@property(nonatomic ,strong) NSNumber *merchantId;/** 商家ID */
@property(nonatomic ,strong) NSString *storeName;/** 店铺名称 */
@property(nonatomic ,strong) NSString *storeDomain;/** 店铺域名 */
@property(nonatomic ,strong) NSString *storeLogoUrl;/** 店铺Logo地址 */
@property(nonatomic ,strong) NSString *storeDesc;/** 店铺描述 */
@property(nonatomic ,strong) NSString *metaKeywords;/** 页面关键词 */
@property(nonatomic ,strong) NSString *metaDesc;/** 页面描述 */
@property(nonatomic ,strong) NSString *storeLabelUrl;/** 店标地址 */
@property(nonatomic ,strong) NSNumber *styleId;/** 风格ID */
@property(nonatomic ,strong) NSNumber *templateId;/** 模板ID */
@property(nonatomic ,strong) NSNumber *productNum;/** 商品数 */
@property(nonatomic ,strong) NSNumber *favorNum;/** 收藏数 */
@property(nonatomic ,strong) NSNumber *creditRating;/** 信用评级 */
@property(nonatomic ,strong) NSNumber *totalSoNum;/** 累计订单数 */
@property(nonatomic ,strong) NSNumber *status;/** 状态 */
@property(nonatomic ,strong) NSDate *createTime;/** 创建时间 */
@property(nonatomic ,strong) NSDate *updateTime;/** 修改时间 */
@property(nonatomic ,strong) NSNumber *showDefaultModule;/** 显示默认模块状态 */
@property(nonatomic ,strong) NSString *merchantQq;/** 商家QQ信息 */
@property(nonatomic ,strong) NSNumber *qqCanShow;/** 显示QQ信息状态*/
@property(nonatomic ,strong) NSString *merchantPhone;/** 商家电话信息 */
@property(nonatomic ,strong) NSNumber *phoneCanShow;/** 显示电话信息状态 */
@property(nonatomic ,strong) NSString *merchantInfoNote;/** 联系方式的说明 */
@property(nonatomic ,strong) NSNumber *noteCanShow;/** 显示说明的状态 */

@property(nonatomic ,strong) NSString *companyName;//公司名称
@property(nonatomic ,strong) NSString *location;//所在地
@property(nonatomic ,strong) NSNumber *skuCount;//sku总数，根据省份id区分
@property(nonatomic ,strong) NSString *freeShipping;//全场包邮信息
@property(nonatomic ,strong) GrouponMerchantRateCommentary *merchantRateCommentary;//店铺评分信息

/**是否锁定店铺名称**/
@property(nonatomic ,strong) NSNumber *isLockName;
@property(nonatomic ,strong) NSNumber *isMainStore;
@property(nonatomic ,strong) NSNumber *isCurrentStore;
@property(nonatomic ,strong) NSNumber *isDeleted;

@property(nonatomic ,strong) NSNumber *onlineCustomerId;

- (GrouponMerchantInfoVO *)merchantInfoVO;
@end
