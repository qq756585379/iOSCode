//
//  OTSNICallCenter.m
//  OneStoreMain
//
//  Created by zhangbin on 14-12-16.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSNICallCenter.h"
#import "ClassifyMessage.h"
#import "CallLoginVO.h"
#import "CallSecondLoginVO.h"
#import "CallRouterVO.h"
#import "CallReceiveVO.h"
#import "CallSendVO.h"
#import "CallMessageFeatureVO.h"
#import "OTSGlobalValue.h"
//category
#import "NSMutableArray+safe.h"
#import "NSMutableDictionary+safe.h"
#import "NSObject+safe.h"
//tool
#import "OTSJsonKit.h"
//global
#import "OTSGlobalValue.h"

#define CallCenterUrlByMethodName(actionName) ([CallCenterUrlByMethodNameWithOutAction(actionName) stringByAppendingString:@".action"])
#define CallCenterUrlByMethodNameWithOutAction(actionName) ([NSString stringWithFormat:@"http://webim.yhd.com/app/customer/%@",actionName])

@implementation OTSNICallCenter

+ (OTSOperationParam *)saveRightInfoWithProduct:(NSDictionary *)productInfo CompletionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"jsonpCallback"] = @"";
    dict[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dict[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    dict[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dict[@"sid"] = [OTSGlobalValue sharedInstance].sid;
    dict[@"rightInfo"] = productInfo;
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"saveRightInfo") type:kRequestPost param:dict callback:aBlock];
    return param;
}

+ (OTSOperationParam *)getChatMessageWithCompletionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"jsonpCallback"] = @"";
    params[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    params[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"history") type:kRequestGet param:params callback:^(id aResponseObject, NSError *anError) {
        ClassifyMessage *vo = nil;
        NSMutableArray *tmpArray = [NSMutableArray array];
        if (!anError &&[aResponseObject isKindOfClass:[NSArray class]]) {
            //正常结果
            vo.isFromHistory = YES;
            for (NSDictionary *dic in aResponseObject) {
                vo = [[ClassifyMessage alloc]initWithDictionary:dic error:nil];
                vo.sortTime = vo.startTime;
                vo.isFromHistory = YES;
                [tmpArray safeAddObject:vo];
            }
            if (aBlock) {
                aBlock(tmpArray, anError);
            }
        }
        else if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]])
        {
            CallHistoryFailedVO *vo = [[CallHistoryFailedVO alloc] initWithDictionary:aResponseObject error:nil];
            if (aBlock) {
                aBlock(vo, anError);
            }
        }
        else//完全不正常
        {
            if (aBlock) {
                aBlock(nil ,anError);
            }
        }
    }];
    return param;
}

+ (OTSOperationParam *)isLoginWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = @"";
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"isLoginWithSut") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallLoginVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallLoginVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存sut
            [OTSGlobalValue sharedInstance].sut = vo.sut;
        }
        else
        {
            [OTSGlobalValue sharedInstance].sut = nil;
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)loginWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"jsonpCallback"] = @"";
    dic[@"needMsgTransfer"] = @"false";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"login") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallSecondLoginVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallSecondLoginVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存cid
            [OTSGlobalValue sharedInstance].cid = vo.cid;
            [OTSGlobalValue sharedInstance].customerId = [vo.userId toNumberIfNeeded];
        }
        else
        {
            [OTSGlobalValue sharedInstance].cid = nil;
            [OTSGlobalValue sharedInstance].customerId = nil;
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)routeWithMerchantId:(NSNumber *)merchantId positionId:(NSNumber *)positionId pmId:(NSNumber *)pmId productId:(NSNumber *)productId  sellerType:(NSNumber *)sellerType orderCode:(NSNumber *)orderCode completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *rightQueryStr = [NSMutableDictionary dictionary];
    rightQueryStr[@"pmId"] = pmId;
    rightQueryStr[@"productId"] = productId;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"merchantId"] = merchantId;
    dic[@"positionId"] = positionId;
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"rightQueryStr"] = [OTSJsonKit stringFromDict:rightQueryStr];
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    if (orderCode) {
        dic[@"orderCode"] = orderCode;
    }
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"route") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallRouterVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallRouterVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存sid
            [OTSGlobalValue sharedInstance].sid = vo.sid;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:vo.sessionId forKey:vo.csrId];
        }
        else
        {
            [OTSGlobalValue sharedInstance].sid = nil;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:nil forKey:vo.csrId];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)createSessionWithMerchantId:(NSNumber *)merchantId positionId:(NSNumber *)positionId toId:(NSString *)toId sellerType:(NSNumber *)sellerType completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"merchantId"] = merchantId;
    dic[@"positionId"] = positionId;
    dic[@"toId"] = toId;
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"rightQueryStr"] = @"";
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"createSession") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallRouterVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallRouterVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存sid
            [OTSGlobalValue sharedInstance].sid = vo.sid;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:vo.sessionId forKey:vo.csrId];
        }
        else
        {
            [OTSGlobalValue sharedInstance].sid = nil;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:nil forKey:vo.csrId];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)sendMsgWithCsrIdForError:(NSString *)csrIdForError messageBody:(NSString *)messageBody messageFeature:(CallMessageFeatureVO *)messageFeature messageType:(NSNumber *)messageType completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"messageBody"] = messageBody;
    dic[@"csrIdForError"] = csrIdForError;
    dic[@"messageFeature"] = messageFeature;
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"sid"] = [OTSGlobalValue sharedInstance].sid;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    dic[@"deviceType"] = @"4"; //ios是4，接口文档没有，方便客服统计流量
    
    if (messageType) {
        dic[@"type"] = messageType;
    }else{
        dic[@"type"] = @100;
    }
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"sendMsg") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallSendVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallSendVO alloc] initWithDictionary:aResponseObject error:nil];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getSessionWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"sid"] = [OTSGlobalValue sharedInstance].sid;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"getSession") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallRouterVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallRouterVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存sid
            [OTSGlobalValue sharedInstance].sid = vo.sessionId;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:vo.sessionId forKey:vo.csrId];
        }
        else
        {
            [OTSGlobalValue sharedInstance].sid = nil;
            [[OTSGlobalValue sharedInstance].messagerSessionInfos safeSetObject:nil forKey:vo.csrId];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)offlineMsgWithCsrId:(NSString *)csrId merchantId:(NSString *)merchantId mcSiteId:(SiteType)mcSiteId completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"csrId"] = csrId;
    dic[@"merchantId"] = merchantId;
    dic[@"mcSiteId"] = @(mcSiteId);
    
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"offlineMsg") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallReceiveVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallReceiveVO alloc] initWithDictionary:aResponseObject error:nil];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)logoutWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"logout") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        //不要在这里面置空cid sut,因为可能会这个接口还没有结束(网络卡的时候)，用户就又登陆重新获取了cid sut,然后这个接口再结束，再置空，并且取消当前所有回调就完蛋了
        
        if (aBlock) {
            aBlock(nil, anError);
        }
    }];
    
    [OTSGlobalValue sharedInstance].sut = nil;
    [OTSGlobalValue sharedInstance].cid = nil;
    [OTSGlobalValue sharedInstance].sid = nil;
    [OTSGlobalValue sharedInstance].recConfTicket = nil;
    [OTSGlobalValue sharedInstance].messagerSessionInfos = @{}.mutableCopy;
    
    return param;
}

+ (OTSOperationParam *)hisMsgWithCsrId:(NSNumber *)csrId customerId:(NSNumber *)customerId mcSite:(SiteType)mcSite curPage:(NSNumber *)curPage rows:(NSNumber *)rows completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"csrId"] = [csrId stringValue];
    dic[@"customerId"] = customerId;
    dic[@"mcSiteId"] = @(mcSite);
    dic[@"curPage"] = curPage;
    dic[@"rows"] = rows;
    dic[@"jsonpCallback"] = @"";
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"hisMsg") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallReceiveVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallReceiveVO alloc] initWithDictionary:aResponseObject error:nil];
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSUploadOperationParam *)paramWithFiles:(NSMutableArray *)files
                            completionBlock:(OTSCompletionBlock)aCallback
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"sid"] = [OTSGlobalValue sharedInstance].sid;
    dic[@"iframe"] = @"true";
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    dic[@"jsonpCallback"] = @"im_file_upload";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    
    OTSUploadOperationParam *param = [OTSUploadOperationParam paramWithUrl:CallCenterUrlByMethodName(@"uploadFile") name:@"xFile" files:files param:dic mimeType:kPng callback:^(id aResponseObject, NSError *anError) {
        //aCallback(aResponseObject, anError);
        CallSendVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            vo = [[CallSendVO alloc] initWithDictionary:aResponseObject error:nil];
        }
        if (aCallback) {
            aCallback(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)recMsgWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"recConfTicket"] = [OTSGlobalValue sharedInstance].recConfTicket?:@"";
    dic[@"cid"] = [OTSGlobalValue sharedInstance].cid;
    dic[@"seqId"] = @([[NSDate date] timeIntervalSince1970]);
    dic[@"t"] = @([[NSDate date] timeIntervalSince1970]);
    dic[@"status"] = @103;
    dic[@"jsonpCallback"] = @"";
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    
    //这是个servlet,不要.action
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodNameWithOutAction(@"recMsg") type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        CallReceiveVO *vo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]) {
            vo = [[CallReceiveVO alloc] initWithDictionary:aResponseObject error:nil];
            
            //保存recConfTicket
            [OTSGlobalValue sharedInstance].recConfTicket = vo.recTicket;
        }
        else
        {
            [OTSGlobalValue sharedInstance].recConfTicket = @"";
        }
        if (aBlock) {
            aBlock(vo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getIMStatusWithPositionID:(NSInteger)positionID
                                       OrderCode:(NSString *)orderCode
                                 completionBlock:(void(^)(NSInteger supplierId, NSInteger sellerType, BOOL isShow))completionBlcok
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    
    // http://webim.yhd.com/app/customer/show_im_app_order/${positionId}/${orderCode}.action
    NSString *url = [NSString stringWithFormat:@"%@/%lld/%@.action",
                     @"http://webim.yhd.com/app/customer/show_im_app_order",
                     (long long)positionID, orderCode];
    OTSOperationParam *param
    = [OTSOperationParam paramWithUrl:url
                                 type:kRequestPost
                                param:dic
                             callback:^(id aResponseObject, NSError *anError) {
                                 if (completionBlcok) {
                                     if (!anError) {
                                         completionBlcok([aResponseObject[@"supplierId"] integerValue],
                                                         [aResponseObject[@"sellerType"] integerValue],
                                                         [aResponseObject[@"isShow"] boolValue]);
                                     } else {
                                         completionBlcok(0, 0, NO);
                                     }
                                 }
                             }];
    return param;
}

+ (OTSOperationParam *)satisfactionEvaluateWithCsrId:(NSNumber *)csdId satisScore:(NSNumber *)satisScore mcSiteId:(SiteType)mcSiteId completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"csrId"] = csdId;
    dict[@"satisScore"] = satisScore;
    dict[@"mcSiteId"] = @(mcSiteId);
    dict[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dict[@"deviceType"] = @"4";
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"satisfactionEvaluate") type:kRequestGet param:dict callback:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]]) {
            if (aBlock) {
                aBlock(aResponseObject,anError);
            }
        }else{
            if (aBlock) {
                aBlock(nil,anError);
            }
        }
    }];
    return param;
}

+(OTSOperationParam *)deleteContactWithCsrId:(NSNumber *)csrId merchantId:(NSNumber *)merchantId mcSiteId:(NSNumber *)mcSiteId completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"csrId"] = csrId;
    dict[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    dict[@"merchantId"] = merchantId;
    dict[@"mcSiteId"] = mcSiteId;
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"delContact") type:kRequestGet param:dict callback:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]]) {
            if (aBlock) {
                aBlock(aResponseObject,anError);
            }
        }else{
            if (aBlock) {
                aBlock(nil,anError);
            }
        }
    }];
    return param;
}

+(OTSOperationParam *)deleteMessagesWithMsgId:(NSString *)msgId sendTime:(NSString *)sendTime completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"msgIds"] = msgId;
    dict[@"sendTimes"] = sendTime;
    dict[@"sut"] = [OTSGlobalValue sharedInstance].sut;
    
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:CallCenterUrlByMethodName(@"deleteMsgs") type:kRequestGet param:dict callback:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSArray class]]){ // 删除成功的会返回回来msgIds，sendIds
            NSMutableArray *dataArray = @[].mutableCopy;
            CallDeleteMsgsResultVO *VO = nil;
            for (NSDictionary *dict in aResponseObject) {
                VO = [[CallDeleteMsgsResultVO alloc]initWithDictionary:dict error:nil];
                [dataArray addObject:VO];
            }
            
            if (aBlock) {
                aBlock(dataArray, anError);
            }
        }
        else{
            if (aBlock) {
                aBlock(nil,anError);
            }
        }
    }];
    return param;
}

+(OTSOperationParam *)sendMsgWithDSVParameterDic:(NSDictionary *)DSVDic CompletionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *dict = @{}.mutableCopy;
    NSString *url=[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@.action?address=%@",
                   @"http://webim.yhd.com/app/show_im_app_supplier",
                   DSVDic[@"categoryId"],
                   DSVDic[@"brandId"],
                   DSVDic[@"pminfoId"],
                   DSVDic[@"mcSite"],
                   DSVDic[@"position"],
                   DSVDic[@"sellerType"],
                   DSVDic[@"address"]
                   ];
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:url type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]]) {
            if (aBlock) {
                aBlock(aResponseObject,anError);
            }
        }else{
            if (aBlock) {
                aBlock(nil,anError);
            }
        }
    }];
    return param;
}

+(OTSOperationParam *)sendUserId:(NSNumber *)userId CompletionBlock:(OTSCompletionBlock)aBlock{
    NSString *url = [NSString stringWithFormat:@"http://webim.yhd.com/app/vip/getOpenInfo.action?endUserId=%@",userId];
    OTSOperationParam *param = [OTSOperationParam paramWithUrl:url type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        if (!anError && [aResponseObject isKindOfClass:[NSDictionary class]]) {
            if (aBlock) {
                aBlock(aResponseObject,anError);
            }
        }else{
            if (aBlock) {
                aBlock(nil,anError);
            }
        }
    }];
    return param;
}
@end
