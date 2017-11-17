//
//  MHNavBarMenuItem.m
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MHNavBarMenuItem.h"

@implementation MHNavBarMenuItem

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.titleColor = UIColorFromRGB(0x4a4a4a);
        self.titleFont = [UIFont systemFontOfSize:17.0f];
    }
    return self;
}

@end
