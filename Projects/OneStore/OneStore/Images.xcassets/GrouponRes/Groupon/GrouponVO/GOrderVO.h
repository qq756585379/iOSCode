//
//  OrderVO.h
//  ProtocolDemo
//
//  Created by vsc on 11-2-12.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponPaymentMethodVO.h"
//@class CouponVo;
#import "GrouponGoodReceiverVO.h"
@class GrouponVO;
#import "GrouponMobileBank.h"

@protocol GrouponOrderV2 <NSObject>

@end

@protocol GrouponOrderItemVO <NSObject>

@end

@interface GOrderVO : OTSValueObject

@property(nonatomic, retain) NSNumber *accountAmount;//账户抵扣
@property(nonatomic, retain) NSNumber *availableCouponNum;//可用抵用券数量
@property(nonatomic, retain) NSNumber *businessType;//businessType = 14 是手机充值订单
@property(nonatomic, retain) NSNumber *canIssuedInvoiceType;//能开发票的类型， 1为普通发票。2为3c发票。3为既有普通发票页有3c发票
@property(nonatomic, retain) NSNumber *cardAmount;//礼品卡抵用
@property(nonatomic, retain) NSNumber *cashAmount;//促销立减金额
@property(nonatomic, retain) NSArray<GrouponOrderV2> *childOrderList;//子订单列表，list<OrderV2>
//@property(nonatomic, retain) CouponVo *coupon;//使用的抵用券
@property(nonatomic, retain) NSNumber *couponAmount;//抵用券抵扣
@property(nonatomic, retain) NSDate *deliverEndDate;//期望配送结束时间
@property(nonatomic, retain) NSDate *deliverStartDate;//期望配送开始时间
@property(nonatomic, retain) NSNumber *deliveryAmount;//运费
@property(nonatomic, retain) NSString *deliveryMethodForString;//送货方式
@property(nonatomic, retain) NSDate *expectReceiveDateTo;//预计送达时间
@property(nonatomic, retain) NSString *gatewayName;//网关名称
@property(nonatomic, retain) GrouponGoodReceiverVO *goodReceiver;//收货地址
@property(nonatomic, retain) GrouponVO *grouponVO;//团购信息
@property(nonatomic, retain) NSNumber *haveSensitiveProduct;//是否有敏感商品，true/false
//@property(nonatomic, retain) NSMutableArray *invoiceList;//发票列表，list<InvoiceVO>
@property(nonatomic, retain) NSNumber *isFresh;//0或1
@property(nonatomic, retain) NSNumber *isOrderExpire;//是否超时 true/false
@property(nonatomic, retain) NSNumber *isYihaodian;//0或1
@property(nonatomic, retain) NSNumber *lefthours;//剩余小时数
@property(nonatomic, retain) NSNumber *leftminite;//剩余分钟数
@property(nonatomic, strong)NSNumber *leftDays; //订单取消的剩余天数。如果lefthours和leftminite为空的情况下就使用这个
@property(nonatomic, retain) NSString *merchantName;//商家名称
@property(nonatomic, retain) NSNumber *merchantId;//商家id
@property(nonatomic, retain) NSNumber *needPoint;
@property(nonatomic, retain) NSNumber *orderAmount;//订单总金额
@property(nonatomic, retain) NSString *orderCode;//订单编号
@property(nonatomic, retain) NSDate *orderCreateTime;//下单时间
@property(nonatomic, retain) NSNumber *orderId;//订单Id
@property(nonatomic, retain) NSMutableArray<GrouponOrderItemVO> *orderItemList;//购买产品列表，list<OrderItemVO>
@property(nonatomic, retain) NSNumber *orderPaymentSignal;//是否付款 true/false
@property(nonatomic, retain) NSNumber *orderStatus;//订单状态编码
@property(nonatomic, retain) NSString *orderStatusForString;//订单状态文字说明
@property(nonatomic, retain) NSNumber *orderTotalWeight;//商品总重量
@property(nonatomic, retain) NSNumber *orderType;//订单类型 1普通订单 2团购订单
@property(nonatomic, retain) NSNumber *paymentAccount;//应付总金额
@property(nonatomic, copy) NSString *paymentMethodForString;//付款方式
@property(nonatomic, retain) NSNumber *paymentSignal;//支付状况 1已支付 2未支付 3部分支付 4待审核
@property(nonatomic, retain) NSNumber *productAmount;//产品金额
@property(nonatomic, retain) NSNumber *productCount;//产品总数
@property(nonatomic, retain) NSNumber *serialVersionUID;
@property(nonatomic, retain) NSNumber *siteType;//0为全部站点，1为1号店，2为1号商场

#pragma mark - 客户端字段
@property(nonatomic, assign) BOOL showAllProduct;//是否显示所有商品
@property(nonatomic, retain) GrouponPaymentMethodVO *paymentMethod;//支付方式
@property(nonatomic, retain) GrouponMobileBank *mobileBank;//支付方式 iphone现在统一用这个表示支付方式
@property(nonatomic, retain) NSString *orderPayPriceString;//订单金额显示
@property(nonatomic, retain) NSString *pointString;//订单详情中显示总积分
@property(nonatomic, retain) NSString *productPriceString;//订单中商品金额，包含满减逻辑

#pragma mark- PublicInterface
/**
 *	功能:订单是否可支付.订单正常，没有完成或者取消。没有支付且是线上支付
 *
 *	@return
 */
- (BOOL)isCanPay;

- (NSString *)leftDateDescribe;
/**
 *	功能:获取订单实际还需要支付的金额
 *
 *	@return
 */
- (NSNumber *)needPayAccount;
/**
 *	订单支付成功后,此订单的金额
 *
 *	@return
 */
- (NSNumber *)orderAccount;
@end

//各种orderStatusString...
#define OTS_ORDER_VO_STATUS_STR_CANCELED                @"已取消"
#define OTS_ORDER_VO_STATUS_STR_WAIT_SETTLEMENT         @"待结算"
#define OTS_ORDER_VO_STATUS_STR_COMPLETED               @"已完成"
#define OTS_ORDER_VO_STATUS_STR_WAIT_PROCEED            @"待处理"
#define OTS_ORDER_VO_STATUS_STR_WAIT_REVIEW             @"待审核"
#define OTS_ORDER_VO_STATUS_STR_RECIEVED                @"已收货"
#define OTS_ORDER_VO_STATUS_STR_SENT_OUT                @"已发货"
#define OTS_ORDER_VO_STATUS_STR_WAIT_RETURN             @"待退货"
#define OTS_ORDER_VO_STATUS_STR_WAIT_CHANGE             @"待换货"
#define OTS_ORDER_VO_STATUS_STR_CHANGING                @"换货中"
#define OTS_ORDER_VO_STATUS_STR_RETURNING               @"退货中"
#define OTS_ORDER_VO_STATUS_STR_RETURNED                @"已退货"
#define OTS_ORDER_VO_STATUS_STR_CHANGED                 @"已换货"
#define OTS_ORDER_VO_STATUS_STR_PROCEEDING              @"处理中"

