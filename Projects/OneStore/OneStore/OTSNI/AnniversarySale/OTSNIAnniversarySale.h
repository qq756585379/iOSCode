//
//  OTSNIAnniversarySale.h
//  OneStoreNI
//
//  Created by hanxiaozhu on 6/12/16.
//  Copyright © 2016 OneStoreNI. All rights reserved.
//

#import "OTSNetworkInterface.h"
#import "OTSOperationParam.h"

@interface OTSNIAnniversarySale : OTSNetworkInterface

/**
 *  主会场街道信息接口
 */
+ (OTSOperationParam *)getASMainPageWithPageId:(NSNumber *)pageId CompletionBlock:(OTSCompletionBlock)aBlock;

/**
 *  主会场栏目接口
 */
+ (OTSOperationParam *)getASColumnContentWithColumnCode:(NSString *)colCode completionBlock:(OTSCompletionBlock)aBlock;

/**
 *  分类的铺底商品
 */
+ (OTSOperationParam *)getCmsColSectionDetailContentByColumnCode:(NSString *)colCode
                                                       sectionId:(NSNumber *)aSectionId
                                                 completionBlock:(OTSCompletionBlock)aBlock;

@end
