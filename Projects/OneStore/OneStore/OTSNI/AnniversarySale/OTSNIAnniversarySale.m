//
//  OTSNIAnniversarySale.m
//  OneStoreNI
//
//  Created by hanxiaozhu on 6/12/16.
//  Copyright © 2016 OneStoreNI. All rights reserved.
//

#import "OTSNIAnniversarySale.h"
#import "OTSCurrentAddress.h"

@implementation OTSNIAnniversarySale

/**
 *  主会场街道信息接口
 */
+ (OTSOperationParam *)getASMainPageWithPageId:(NSNumber *)pageId CompletionBlock:(OTSCompletionBlock)aBlock {
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    paramDict[@"pageid"] = pageId;
    paramDict[@"provinceid"] = [OTSCurrentAddress sharedInstance].currentProvinceId;
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"mobileservice" methodName:@"loadCmsPage" versionNum:nil type:kRequestPost param:paramDict callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    return param;
}

/**
 *  主会场栏目接口
 */
+ (OTSOperationParam *)getASColumnContentWithColumnCode:(NSString *)colCode completionBlock:(OTSCompletionBlock)aBlock {
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    paramDict[@"code"] = colCode;
    paramDict[@"provinceid"] = [OTSCurrentAddress sharedInstance].currentProvinceId;
    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"mobileservice" methodName:@"loadCmsColContent" versionNum:nil type:kRequestPost param:paramDict callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    return param;
}

/**
 *  分类的铺底商品
 */
+ (OTSOperationParam *)getCmsColSectionDetailContentByColumnCode:(NSString *)colCode
                                                       sectionId:(NSNumber *)aSectionId
                                                 completionBlock:(OTSCompletionBlock)aBlock{
    NSMutableDictionary *paramDict = @{}.mutableCopy;
    paramDict[@"code"] = colCode;
    paramDict[@"provinceid"] = [OTSCurrentAddress sharedInstance].currentProvinceId;
    paramDict[@"sectionid"] = aSectionId;

    OTSOperationParam *param = [OTSOperationParam paramWithBusinessName:@"mobileservice" methodName:@"loadCmsColSectionDetailContent" versionNum:nil type:kRequestPost param:paramDict callback:^(id aResponseObject, NSError *anError) {
        if (aBlock) {
            aBlock(aResponseObject, anError);
        }
    }];
    
    return param;
}

@end
