//
//  DownloadOperation.m
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

//说明：重写main方法，在把任务operation加入到队列后，队列会自动调用任务的start方法，start方法内部会调用main方法来完成操作
-(void)main{
    if (self.isCancelled) return;
    NSURL *downloadUrl = [NSURL URLWithString:self.url];
    NSData *data = [NSData dataWithContentsOfURL:downloadUrl]; // 这行会比较耗时
    if (self.isCancelled) return;
    UIImage *image = [UIImage imageWithData:data];
    if (self.isCancelled) return;
    NSLog(@"--%@--", [NSThread currentThread]);
    if ([self.delegate respondsToSelector:@selector(operation:didFinishDownloadImage:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{ // 回到主线程, 传递图片数据给代理对象
            [self.delegate operation:self didFinishDownloadImage:image];
        });
    }
}

@end
