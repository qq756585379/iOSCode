//
//  OTSOperationManager.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface OTSOperationManager : AFHTTPSessionManager

@property(nonatomic, strong) NSString *hostClassName;//宿主名称

-(void)cancelAllOperations;

+ (instancetype)manager;

+ (instancetype)managerWithOwner:(id)owner;

@end
