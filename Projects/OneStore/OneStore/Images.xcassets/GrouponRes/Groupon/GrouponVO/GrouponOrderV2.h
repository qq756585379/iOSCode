//
//  OrderV2.h
//  TheStoreApp
//
//  Created by yangxd on 11-6-13.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponMobileBank.h"
@class GrouponOrderVO;
#import "GOrderVO.h"

@protocol GrouponMobileBank <NSObject>

@end

@interface GrouponOrderV2 : GOrderVO

@property(nonatomic, retain) NSNumber *gateway;//支付方式id
@property(nonatomic, strong) NSString *gatewayName;//支付方式名称
@property(nonatomic, strong) NSNumber *isYihaodian;//0一号商城， 1一号店
@property(nonatomic, strong) NSNumber *mainOrderId;//子订单的主订单id

//bamboo新字段
//@property (strong, nonatomic) NSMutableArray * groupItemArray;
@property (strong, nonatomic) NSDate * startPeisongDate;
@property (strong, nonatomic) NSNumber * canCancelChiledOrder;
//@property (strong, nonatomic) NSMutableArray * imgURLArray;//排重图片
@property (nonatomic, strong) NSNumber *isGiftCardOrder;//礼品卡订单
/**
 *	是否是电子礼品卡订单
 */
@property (nonatomic, strong) NSNumber *isEleGitfCardOrder;

@property(nonatomic, retain) NSNumber *availableCardAmount;//可用礼品卡余额

@property(nonatomic, retain) NSNumber *orderEleCardFaceValue;    //用户订单礼品卡面值

/**
 * 是否可以评论  1 可评论  2 可追加评论 3 不可评论  默认为不可评论
 */
@property(nonatomic, strong)NSNumber * commentState;

/**
 * 用户订单礼品卡充值状态 1、充值中 2、已充值 3、取消（订单被取消或自动取消）
 */
@property(nonatomic, strong)NSNumber *orderEleCardStatus;
//补开发票新字段
/**
 * 是否能补开发票，其中一个子单能补开，则整单显示补开发票
 */
@property (nonatomic, strong) NSNumber *isCanReissueInvoice;

/**
 * 是否有补开发票记录
 */
@property (nonatomic, strong) NSNumber *isHaveReissueInvoiceRecord;
@property(nonatomic, strong)NSString *deliveryTypeStr;//包裹配送状态描述

#pragma mark- 
@property(nonatomic, strong) NSArray<GrouponMobileBank> *bankList; //List<MobileBank> 订单的支付方式列表
@property(nonatomic, strong) GrouponMobileBank *currentBrank; //当前选中的支付方式
@property(nonatomic, assign) BOOL isCanChangePayWay; //是否能修改支付方式
@property(nonatomic, assign) BOOL isPaySuccess;
@property (nonatomic, copy) NSString *paymentMethodForString;

@property (nonatomic, strong) NSNumber *orderPaymentSignal;

@property (nonatomic, strong) NSNumber *orderStatus;

#pragma mark- publicInterface
/**
 *	功能:订单是否能评论
 *
 *	@return
 */
- (BOOL)isComment;

/**
 *	功能:返回是否是电子礼品卡订单
 *
 *	@return
 */
- (BOOL)isGiftCard;

/**
 *	功能:返回是否为实体礼品卡
 *
 *	@return
 */
- (BOOL)isEntityGiftCard;

//- (id)initWithOrderVO:(OrderVO *)anOrderVO;

/**
 *	功能:返回订单是否支付成功
 *
 *	@return <#return value description#>
 */
- (BOOL)isPaySuccess;

/**
 *	返回是否是银行转账订单
 *
 *	@return
 */
- (BOOL )isBankTransferOrder;


@end
