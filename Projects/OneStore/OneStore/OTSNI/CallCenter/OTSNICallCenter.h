//
//  OTSNICallCenter.h
//  OneStoreMain
//
//  Created by zhangbin on 14-12-16.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSNetworkInterface.h"
//vo
#import "CallLoginVO.h"
#import "CallSecondLoginVO.h"
#import "CallRouterVO.h"
#import "CallReceiveVO.h"
#import "CallSendVO.h"
#import "CallMessageFeatureVO.h"
#import "CallHistoryFailedVO.h"
#import "CallDeleteMsgsResultVO.h"

typedef NS_ENUM(NSInteger, PositionType)
{
    kType_ShopHome = 1,             //店铺
    kType_Product,                  //商详
    KType_Order = 4,                //订单
    kType_Product_Mine = 11,        //自营商详
    KType_SG_ShopProduct = 13,      //闪购商城商详
    KType_SG_MineProduct = 21,      //闪购自营商详
    kType_TG_ShopProduct = 6,       //团购商城商详
    KType_TG_MineProduct = 20,      // 团购自营商详
    KType_VIPService = 22,          // VIP客服
};

typedef NS_ENUM(NSInteger, SiteType)
{
    kType_SelfSupport = 1,          //自营
    kType_Medicine,                 //药网
    kType_Shop,                     //商城
};

typedef NS_ENUM(NSInteger, ResultType)
{
    kType_SidExpire_One = 11202,                 //sid过期1
    kType_SidExpire_Two = 11401,                 //sid过期2
    kType_SutExpire     = 11101,                 //sut失效
    kType_CidExpire     = 11402,                 //认证过期
    kType_MultiLink     = 11003,                 //多个长链接
    kType_Timeout       = 11001,                 //轮询超时
    kType_TokenExpire   = -888,                  //token过期
};

typedef NS_ENUM(NSInteger, SendType)

{
    kType_ToShop = 1,                 //给商家
    kType_ToCustomer,                 //给买家
    kType_System,                     //系统消息
};

@interface OTSNICallCenter : OTSNetworkInterface

/**
 *  获取聊天资料
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)getChatMessageWithCompletionBlock:(OTSCompletionBlock)aBlock;

/**
 *  校验登陆
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)isLoginWithCompletionBlock:(OTSCompletionBlock)aBlock;


/**
 *  二次登陆
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)loginWithCompletionBlock:(OTSCompletionBlock)aBlock;

/**
 *  路由
 *
 *  @param merchantId 商铺id
 *  @param positionId site
 *  @param pmId
 *  @param productId
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)routeWithMerchantId:(NSNumber *)merchantId positionId:(NSNumber *)positionId pmId:(NSNumber *)pmId productId:(NSNumber *)productId  sellerType:(NSNumber *)sellerType orderCode:(NSNumber *)orderCode completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  创建session
 *
 *  @param merchantId 商铺id
 *  @param positionId site
 *  @param toId       目标id
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)createSessionWithMerchantId:(NSNumber *)merchantId positionId:(NSNumber *)positionId toId:(NSString *)toId  sellerType:(NSNumber *)sellerType completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  发送消息
 *
 *  @param csrIdForError  客服id
 *  @param messageBody    消息内容
 *  @param messageFeature 字体格式
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)sendMsgWithCsrIdForError:(NSString *)csrIdForError messageBody:(NSString *)messageBody messageFeature:(CallMessageFeatureVO *)messageFeature messageType:(NSNumber *)messageType completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  获取session
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)getSessionWithCompletionBlock:(OTSCompletionBlock)aBlock;

/**
 *  获取离线消息
 *
 *  @param csrId      客服id
 *  @param merchantId 商铺id
 *  @param mcSite     站点
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)offlineMsgWithCsrId:(NSString *)csrId merchantId:(NSString *)merchantId mcSiteId:(SiteType)mcSiteId completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  登出
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)logoutWithCompletionBlock:(OTSCompletionBlock)aBlock;

/**
 *  历史消息
 *
 *  @param csrId      客服id
 *  @param customerId 顾客id
 *  @param mcSite     站点
 *  @param curPage    当前页
 *  @param rows       每页大小
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)hisMsgWithCsrId:(NSNumber *)csrId customerId:(NSNumber *)customerId mcSite:(SiteType)mcSite curPage:(NSNumber *)curPage rows:(NSNumber *)rows completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  上传图片
 *
 *  @param files     图片文件
 *  @param aCallback
 *
 *  @return
 */
+ (OTSUploadOperationParam *)paramWithFiles:(NSMutableArray *)files
                            completionBlock:(OTSCompletionBlock)aCallback;

/**
 *  轮询消息长链接
 *
 *  @param aBlock
 *
 *  @return
 */
+ (OTSOperationParam *)recMsgWithCompletionBlock:(OTSCompletionBlock)aBlock;

/** 点击联系客服时客户游览的商品 */
+ (OTSOperationParam *)saveRightInfoWithProduct:(NSDictionary *)productInfo CompletionBlock:(OTSCompletionBlock)aBlock;

/** 订单也是否显示客服 */
+ (OTSOperationParam *)getIMStatusWithPositionID:(NSInteger)positionID
                                       OrderCode:(NSString *)orderCode
                                 completionBlock:(void(^)(NSInteger supplierId, NSInteger sellerType, BOOL isOnline))completionBlcok;
/** 客服评价 */
+ (OTSOperationParam *)satisfactionEvaluateWithCsrId:(NSNumber *)csdId satisScore:(NSNumber *)satisScore mcSiteId:(SiteType)mcSiteId completionBlock:(OTSCompletionBlock)aBlock;

/** 删除联系人 */
+(OTSOperationParam *)deleteContactWithCsrId:(NSNumber *)csrId merchantId:(NSNumber *)merchantId mcSiteId:(NSNumber *)mcSiteId completionBlock:(OTSCompletionBlock)aBlock;


/** 删除消息 */
+(OTSOperationParam *)deleteMessagesWithMsgId:(NSString *)msgId sendTime:(NSString *)sendTime completionBlock:(OTSCompletionBlock)aBlock;

/**一品多供*/
+(OTSOperationParam *)sendMsgWithDSVParameterDic:(NSDictionary *)DSVDic CompletionBlock:(OTSCompletionBlock)aBlock;

/**vip3*/
+(OTSOperationParam *)sendUserId:(NSNumber*)userId CompletionBlock:(OTSCompletionBlock)aBlock;
@end
