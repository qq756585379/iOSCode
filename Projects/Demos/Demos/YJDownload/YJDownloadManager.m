//
//  YJDownloadManager.m
//  Demos
//
//  Created by 杨俊 on 2017/11/3.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "YJDownloadManager.h"

@implementation YJDownloadManager

static YJDownloadManager *_downloadManager;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    return _downloadManager;
}



@end
