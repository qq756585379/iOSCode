//
//  OTSBgDownload.h
//  OneStorePhone
//
//  Created by 黄吉明 on 2/6/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSFuncDefine.h"

@interface OTSBgDownload : NSObject

AS_SINGLETON(OTSBgDownload)

- (void)downloadFrom:(NSString *)aURL to:(NSString *)aPath completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (void)downloadFrom:(NSString *)aURL to:(NSString *)aPath fileName:(NSString *)fileName completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end
