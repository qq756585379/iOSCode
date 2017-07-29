//
//  PhoneTabBarItemVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneTabBarItemVO : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *hostString;
@property (nonatomic, assign) BOOL showWord;
@property (nonatomic, strong) NSString *selectHexColor;

@end
