//
//  OTSNIBabyCenter.m
//  Baby
//
//  Created by zhangbin on 14-11-3.
//  Copyright (c) 2014年 yhd. All rights reserved.
//

#import "OTSNIBabyCenter.h"
#import "ActivityVOJson.h"
#import "BaoBaoPhotoVOJson.h"
#import "BaoBaoPersonPhotoVO.h"
#import "BaoBaoPhotoVO.h"

@implementation OTSNIBabyCenter

+ (OTSOperationParam *)getActivityById:(NSNumber *)activityId sortType:(NSNumber *)sortType pageIndex:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getActivityById" versionNum:nil type:kRequestGet param:@{@"activityId":activityId,@"sortType":sortType,@"currPage":pageIndex,@"pageSize":pageSize} callback:^(id aResponseObject, NSError *anError) {
        BaoBaoPhotoVOJson *baoBaoPhotoVOJson = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            baoBaoPhotoVOJson = [[BaoBaoPhotoVOJson alloc] init];
        }
        if (aBlock) {
            aBlock(baoBaoPhotoVOJson, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)uploadPicByActivity:(NSNumber *)activityId photoUrl:(NSString *)photoUrl photoTitle:(NSString *)photoTitle completionBlock:(OTSCompletionBlock)aBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:activityId forKey:@"activityId"];
    [dic setValue:photoUrl forKey:@"imgUrl"];
    [dic setValue:photoTitle forKey:@"photoTitle"];
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"uploadPicByActivity" versionNum:nil type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)voteByPhotoId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"voteByPhotoId" versionNum:nil type:kRequestGet param:@{@"photoId":photoId} callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getBabyInfoWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getBabyInfo" versionNum:nil type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        BabyInfo *babyInfo = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            babyInfo = [[BabyInfo alloc] init];
        }
        if (aBlock) {
            aBlock(babyInfo, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)updateBabyInfo:(BabyInfo *)babyInfoVO completionBlock:(OTSCompletionBlock)aBlock
{
    NSDictionary *dic = [NSDictionary dictionary];
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"updateBabyInfo" versionNum:nil type:kRequestGet param:dic callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getPersonPhotoByUserIdWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getPersonPhotoByUserId" versionNum:nil type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([aResponseObject isKindOfClass:[NSArray class]] && !anError) {
            for (id dic in aResponseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    BaoBaoPersonPhotoVO *vo = [[BaoBaoPersonPhotoVO alloc] init];
                    if (vo) {
                        [arr addObject:vo];
                    }
                }
            }
        }
        if (aBlock) {
            aBlock(arr, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)deletePhotoByUserId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"deletePhotoByUserId" versionNum:nil type:kRequestGet param:@{@"photoId":photoId} callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getActivityListWithPage:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getActivityListWithPage" versionNum:nil type:kRequestGet param:@{@"currPage":pageIndex,@"pageSize":pageSize,@"status":@3} callback:^(id aResponseObject, NSError *anError) {
        ActivityVOJson *activityVOJson = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            activityVOJson = [[ActivityVOJson alloc] init];
        }
        if (aBlock) {
            aBlock(activityVOJson, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getTotalBabyNumWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getTotalBabyNum" versionNum:nil type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getPhotoList:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getPhotoList" versionNum:nil type:kRequestGet param:@{@"currPage":pageIndex,@"pageSize":pageSize} callback:^(id aResponseObject, NSError *anError) {
        BaoBaoPhotoVOJson *baoBaoPhotoVOJson = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            baoBaoPhotoVOJson = [[BaoBaoPhotoVOJson alloc] init];
        }
        if (aBlock) {
            aBlock(baoBaoPhotoVOJson, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)getPhotoDetailByPhotoId:(NSNumber *)photoId completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"getPhotoDetailByPhotoId" versionNum:nil type:kRequestGet param:@{@"photoId":photoId} callback:^(id aResponseObject, NSError *anError) {
        BaoBaoPhotoVO *baoBaoPhotoVO = nil;
        if ([aResponseObject isKindOfClass:[NSDictionary class]]&&!anError) {
            baoBaoPhotoVO = [[BaoBaoPhotoVO alloc] init];
        }
        if (aBlock) {
            aBlock(baoBaoPhotoVO, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)hasNotAuditPhotoByUserIdWithCompletionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"hasNotAuditPhotoByUserId" versionNum:nil type:kRequestGet param:nil callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

+ (OTSOperationParam *)hasPhotoInActivity:(NSNumber *)activityId completionBlock:(OTSCompletionBlock)aBlock
{
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"baobao" methodName:@"hasPhotoInActivity" versionNum:nil type:kRequestGet param:@{@"activityId":activityId} callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

@end
