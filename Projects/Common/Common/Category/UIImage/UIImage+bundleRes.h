//
//  UIImage+bundleRes.h
//  Common
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (bundleRes)

+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString *)bundleName;

@end
