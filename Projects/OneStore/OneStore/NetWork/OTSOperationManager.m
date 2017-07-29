//
//  OTSOperationManager.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSOperationManager.h"
#import "OTSWeakObjectDeathNotifier.h"

@implementation OTSOperationManager

+ (instancetype)manager{
    return [self managerWithOwner:nil];
}

+ (instancetype)managerWithOwner:(id)owner{
    OTSOperationManager *operationManager = [super manager];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"application/javascript", @"text/plain", @"text/json", @"application/x-javascript", nil];
    operationManager.hostClassName = NSStringFromClass([owner class]);
    
    if (owner) {
        OTSWeakObjectDeathNotifier *wo = [OTSWeakObjectDeathNotifier new];
        [wo setOwner:owner];
        [wo setBlock:^(OTSWeakObjectDeathNotifier *sender) {
            [operationManager cancelOperationsAndRemoveFromNetworkManager];
        }];
    }
    
    //缓存策略
    operationManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    static dispatch_once_t onceTokenInManager;
    dispatch_once(&onceTokenInManager, ^{
//        [NSURLCache setSharedURLCache:[OTSURLCache standardURLCache]];
    });
    
    //query格式
//    [operationManager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
//        return [OTSNetworkQuery queryStringFromParameters:parameters encoding:NSUTF8StringEncoding];;
//    }];
    
    //session无效
//    __weak OTSOperationManager *weakManager = operationManager;
//    [operationManager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
//        __strong OTSOperationManager *strongManager = weakManager;
//        strongManager.sessionIsInvalid = YES;
//    }];
    return operationManager;
}

- (void)cancelOperationsAndRemoveFromNetworkManager{
    
}

-(void)cancelAllOperations{
    
}

@end








