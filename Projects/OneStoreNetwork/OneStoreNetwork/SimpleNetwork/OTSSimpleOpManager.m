//
//  OTSSimpleOpManager.m
//  OneStoreNetwork
//
//  Created by huangjiming on 9/7/15.
//  Copyright (c) 2015 OneStoreNetwork. All rights reserved.
//

#import "OTSSimpleOpManager.h"

@implementation OTSSimpleOpManager

- (void)requestWithDomain:(NSString *)domain param:(NSDictionary *)param{
    if (domain.length <= 0) {
        return;
    }
    [self GET:domain parameters:param progress:nil success:nil failure:nil];
}

- (void)requestWithFullUrlString:(NSString *)urlStr{
    [self requestWithDomain:urlStr param:nil];
}

@end
