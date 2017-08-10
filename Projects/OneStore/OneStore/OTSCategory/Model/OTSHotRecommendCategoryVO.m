//
//  OTSHotRecommendCategoryVO.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSHotRecommendCategoryVO.h"
#import "CategoryVO.h"

@implementation OTSHotRecommendCategoryVO

- (CategoryVO *)toCategoryVO {
    CategoryVO *categroyVO = [CategoryVO new];
    categroyVO.name = self.words;
    categroyVO.iconPicUrl = self.picUrl;
    categroyVO.url = self.linkUrl;
    categroyVO.type = self.type;
    if (self.hot.length > 0) {
        NSArray<NSString *> *array = [self.hot componentsSeparatedByString:@"_"];
        categroyVO.isHighLight = @([[array safeObjectAtIndex:0] integerValue]);
        categroyVO.isHot = @([[array safeObjectAtIndex:0] integerValue]);
        categroyVO.isNew = @([[array safeObjectAtIndex:0] integerValue]);
    }
    if ([self.linkUrl hasPrefix:@"yhd://adproducts"]) {
        categroyVO.appLinkUrl = self.linkUrl;
    }
    categroyVO.hotRecommend = @(1);
    return categroyVO;
}

@end
