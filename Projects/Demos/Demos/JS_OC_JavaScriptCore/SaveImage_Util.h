//
//  SaveImage_Util.h
//  Demos
//
//  Created by 杨俊 on 2017/10/30.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SaveImage_Util : NSObject

+ (BOOL)saveImage:(UIImage *)saveImage ImageName:(NSString *)imageName back:(void(^)(NSString *imagePath))back;

@end
