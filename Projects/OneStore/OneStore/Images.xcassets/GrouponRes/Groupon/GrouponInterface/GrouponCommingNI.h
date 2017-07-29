//
//  GrouponCommingNI.h
//  GrouponProject
//
//  Created by Vect Xi on 11/8/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSNetworkInterface.h"
#import "GrouponCommingPage.h"

@interface GrouponCommingNI : OTSNetworkInterface

+ (OTSOperationParam *)commingDateParamByAreaId:(NSInteger)areaId
                                          completionBlock:(void(^)(NSDictionary *dates))acompletionBlock;

+ (OTSOperationParam *)commingGrouponParamByAreaId:(NSInteger)areaId
                                              date:(NSString *)date
                                       currentPage:(NSInteger)page
                                          pageSize:(NSInteger)pageSize
                                   completionBlock:(void(^)(GrouponCommingPage *page, NSError *error))aCompletionBlock;

@end
