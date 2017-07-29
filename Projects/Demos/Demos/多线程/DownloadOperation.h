//
//  DownloadOperation.h
//  Demos
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DownloadOperation;

@protocol XBOperationDelegate <NSObject>
-(void)operation:(DownloadOperation *)operation didFinishDownloadImage:(UIImage *)image;
@end

@interface DownloadOperation : NSOperation

@property (nonatomic, weak)id <XBOperationDelegate> delegate;

@property (nonatomic, copy) NSString *url;

//indexPath 和tableview中的cell相对应
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
