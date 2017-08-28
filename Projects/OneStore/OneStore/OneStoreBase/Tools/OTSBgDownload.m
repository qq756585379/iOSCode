//
//  OTSBgDownload.m
//  OneStorePhone
//
//  Created by 黄吉明 on 2/6/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSBgDownload.h"
//category
#import "NSObject+PerformBlock.h"

@implementation OTSBgDownload

DEF_SINGLETON(OTSBgDownload)

#pragma mark - API
- (void)downloadFrom:(NSString *)aURL to:(NSString *)aPath completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler{
    [self downloadFrom:aURL to:aPath fileName:nil completionHandler:completionHandler];
}

- (void)downloadFrom:(NSString *)aURL to:(NSString *)aPath fileName:(NSString *)fileName completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler{
    [self performInThreadBlock:^{
        AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSProgress *progress;
        NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aURL]] progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSString *fullPath = [aPath stringByAppendingPathComponent:fileName?:response.suggestedFilename];
            if (fullPath) {
                return [NSURL fileURLWithPath:fullPath];
            }else {
                return nil;
            }
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (completionHandler) {
                completionHandler(response, filePath, error);
            }
        }];
        [downloadTask resume];
    }];
}

@end
