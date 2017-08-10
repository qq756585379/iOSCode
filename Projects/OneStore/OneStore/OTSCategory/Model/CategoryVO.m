//
//  CategoryVO.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "CategoryVO.h"

@implementation CategoryVO

-(NSNumber *)showType{
    if (!_showType) {
        _showType = [NSNumber numberWithInteger:0];//接口可能没有这个字段，默认赋值为0
    }
    return _showType;
}

- (void)setWords:(NSString *)words {
    _words = words;
    self.hotRecommend = @(1);
    if (_words.length > 0) {
        self.name = _words;
    }
}

- (void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
    if (_picUrl.length > 0) {
        self.iconPicUrl = _picUrl;
    }
}

- (void)setLinkUrl:(NSString *)linkUrl {
    _linkUrl = linkUrl;
    if (_linkUrl.length > 0) {
        self.url = linkUrl;
    }
    if ([_linkUrl hasPrefix:@"yhd://adproducts"]) {
        self.appLinkUrl = self.linkUrl;
    }
}

- (void)setCategoryParentId:(NSNumber *)categoryParentId {
    _categoryParentId = categoryParentId;
    self.parentId = _categoryParentId;
}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    if (_categoryName.length > 0) {
        self.name = _categoryName;
    }
}

- (void)setHot:(NSString *)hot {
    _hot = hot;
    if (_hot.length > 0) {
        NSArray<NSString *> *array = [_hot componentsSeparatedByString:@"_"];
        self.isHighLight = @([[array safeObjectAtIndex:0] integerValue]);
        self.isHot = @([[array safeObjectAtIndex:0] integerValue]);
        self.isNew = @([[array safeObjectAtIndex:0] integerValue]);
    }
}


@end
