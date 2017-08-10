//
//  HomePromotionDetailVO.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "HomePromotionDetailVO.h"

@implementation HomePromotionDetailVO

- (NSString *)title
{
    if(_title == nil){
        _title = @"";
    }
    return _title;
}

- (NSString *)subTitle
{
    if(_subTitle == nil){
        _subTitle = @"";
    }
    return _subTitle;
}

@end
