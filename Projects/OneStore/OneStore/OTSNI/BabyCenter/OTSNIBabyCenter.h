//
//  OTSNIBabyCenter.h
//  Baby
//
//  Created by zhangbin on 14-11-3.
//  Copyright (c) 2014年 yhd. All rights reserved.
//

#import "OTSNetworkInterface.h"
#import "BabyInfo.h"

@interface OTSNIBabyCenter : OTSNetworkInterface

//查询活动详情
+ (OTSOperationParam *)getActivityById:(NSNumber *)activityId sortType:(NSNumber *)sortType pageIndex:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock;

//编辑照片
+ (OTSOperationParam *)uploadPicByActivity:(NSNumber *)activityId photoUrl:(NSString *)photoUrl photoTitle:(NSString *)photoTitle completionBlock:(OTSCompletionBlock)aBlock;

//赞
+ (OTSOperationParam *)voteByPhotoId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock;

//获取宝宝资料
+ (OTSOperationParam *)getBabyInfoWithCompletionBlock:(OTSCompletionBlock)aBlock;

//编辑宝宝资料
+ (OTSOperationParam *)updateBabyInfo:(BabyInfo *)babyInfoVO completionBlock:(OTSCompletionBlock)aBlock;

//获取相册
+ (OTSOperationParam *)getPersonPhotoByUserIdWithCompletionBlock:(OTSCompletionBlock)aBlock;

//删除照片
+ (OTSOperationParam *)deletePhotoByUserId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock;

//获取活动列表
+ (OTSOperationParam *)getActivityListWithPage:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock;

//获取参与总人数
+ (OTSOperationParam *)getTotalBabyNumWithCompletionBlock:(OTSCompletionBlock)aBlock;

//获取所有照片
+ (OTSOperationParam *)getPhotoList:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock;

//获取照片详情
+ (OTSOperationParam *)getPhotoDetailByPhotoId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock;

//获取是否有未通过审核
+ (OTSOperationParam *)hasNotAuditPhotoByUserIdWithCompletionBlock:(OTSCompletionBlock)aBlock;

//是否在活动中已有照片
+ (OTSOperationParam *)hasPhotoInActivity:(NSNumber *)activityId completionBlock:(OTSCompletionBlock)aBlock;

@end
