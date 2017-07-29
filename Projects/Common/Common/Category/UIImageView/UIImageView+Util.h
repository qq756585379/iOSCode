//
//  UIImageView+Util.h
//  MiHome
//
//  Created by yangjun on 2017/4/26.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

/**网络请求图片显示为圆图*/
- (void)setCircleImageUrl:(NSString *)imageUrl andPlaceHolderImg:(NSString *)placeholdImg;

@end
