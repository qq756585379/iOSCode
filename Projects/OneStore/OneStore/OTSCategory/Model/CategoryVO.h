//
//  CategoryVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryADSDataVO.h"
@class CategoryVO;

@interface CategoryVO : NSObject

@property(nonatomic, strong)NSNumber *nid;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSNumber *categoryId;
@property(nonatomic, strong)NSNumber *parentId;
@property(nonatomic, strong)NSNumber *vistualCategoryType;
@property(nonatomic, strong)NSNumber *isGoodness;
@property(nonatomic, strong)NSString *goodnessDesc;
@property(nonatomic, strong)NSNumber *isHighLight;
@property(nonatomic, strong)NSNumber *isNew;//0表示不显示new，1表示显示new
@property(nonatomic, strong)NSNumber *isHot;
@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSString *keywords;
@property(nonatomic, strong)NSMutableArray<CategoryVO *> *childrens;
@property(nonatomic, strong)CategoryADSDataVO *adsVO;
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, strong)UIImage *hightlightedImage;

@property(nonatomic, strong)NSString *iconPicUrl;//追加类目图片字段
@property(nonatomic, strong)NSNumber *showType;//控制类目点击跳转 默认0点击跳转 1点击不跳转
@property(nonatomic, strong)NSString *appLinkUrl;//一点通列表URL

/****
 热门推荐下，更换接口 getMobReCateList 接口
 ****/
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *words;
@property (nonatomic, strong) NSNumber *hotRecommend; // 1表示从 OTSHotRecommendCategoryVO 转换过来

/****
 热门推荐下，更换接口 getMobSubCategorysById 接口
 ****/
@property(nonatomic, strong)NSString *categoryName;
//@property(nonatomic, strong)NSNumber *categoryId;
@property(nonatomic, strong)NSNumber *categoryParentId;

@end
