//
//  Header.h
//  GrouponProject
//
//  Created by zhangbin on 14-9-30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#ifndef GrouponProject_Header_h
#define GrouponProject_Header_h

/**
 *  0-默认的排序列表；1-人气最高；2-折扣最多；3-价格最低；4-最新发布
 */
typedef NS_ENUM(NSInteger, BrandGrouponSortType) {
    /**
     *  默认的排序列表
     */
    BrandGrouponSortTypeDefault = 0,
    /**
     *  人气最高
     */
    BrandGrouponSortTypeHot,
    /**
     *  折扣最多
     */
    BrandGrouponSortTypeDiscount,
    /**
     *  价格最低
     */
    BrandGrouponSortTypePeice,
    /**
     *  最新发布
     */
    BrandGrouponSortTypeNew
};

/**
 *  类型
 */
typedef NS_ENUM(NSInteger, GrouponVirtualType) {
    /**
     *  商品团购
     */
    GrouponVirtualTypeMerchandise = 0,
    /**
     *  生活服务团购
     */
    GrouponVirtualTypeLife,
    /**
     *  今日上线
     */
    GrouponVirtualTypeNew,
    /**
     *  团购预告
     */
    GrouponVirtualTypeNotice,
    /**
     *  品牌团
     */
    GrouponVirtualTypeBrand,
    /**
     *  生活服务今日上新团购
     */
    GrouponVirtualTypeLifeNew,
    /**
     *  所有
     */
    GrouponVirtualTypeAll = 100
};

/**
 *  类型
 */
typedef NS_ENUM(NSInteger, GrouponObjectType)
{
    /**
     *  团购
     */
    GrouponObjectTypeNormal = 1,
    /**
     *  品牌团
     */
    GrouponObjectTypeBrand
};

#endif
