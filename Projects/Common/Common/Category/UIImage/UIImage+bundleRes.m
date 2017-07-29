//
//  UIImage+bundleRes.m
//  Common
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "UIImage+bundleRes.h"

@implementation UIImage (bundleRes)

+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString *)bundleName{
    if (bundleName.length) {
        name = [NSString stringWithFormat:@"%@.bundle/%@",bundleName,name];
    }
    return [UIImage imageNamed:name];
}

@end
