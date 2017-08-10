//
//  OTSHotRecommendCategoryVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryVO;

@interface OTSHotRecommendCategoryVO : NSObject

/****
 热门推荐下，三级类目数据更换接口，单独请求，以下是热门推荐下的类目 VO 会用到的字段
 ****/
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *words;

// 将此 VO 转化为 CategoryVO
- (CategoryVO *)toCategoryVO;

@end
