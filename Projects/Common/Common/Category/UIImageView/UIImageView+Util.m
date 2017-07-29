//
//  UIImageView+Util.m
//  MiHome
//
//  Created by yangjun on 2017/4/26.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "UIImageView+Util.h"
#import "UIImage+Util.h"
#import "CommonDefine.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Util)

- (void)setCircleImageUrl:(NSString *)imageUrl andPlaceHolderImg:(NSString *)placeholdImg{
    UIImage *placeholder = [[UIImage imageNamed:placeholdImg] circleImage];
    WEAK_SELF
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl]
            placeholderImage:placeholder
                     options:SDWebImageCacheMemoryOnly
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       
                       weakSelf.image = image ? [image circleImage] : placeholder;
                   }];
}

@end
