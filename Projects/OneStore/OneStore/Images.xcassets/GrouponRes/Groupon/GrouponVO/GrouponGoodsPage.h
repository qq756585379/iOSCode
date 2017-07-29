//
//  GrouponGoodsPage.h
//  GrouponProject
//
//  Created by zhangbin on 14-10-8.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSValueObject.h"
#import "GrouponVO.h"

@interface GrouponGoodsPage : OTSValueObject

@property (strong, nonatomic) NSNumber *currentPage;
@property (strong, nonatomic) NSMutableArray<GrouponVO> *objList;
@property (strong, nonatomic) NSNumber *pageSize;
@property (strong, nonatomic) NSNumber *totalSize;

@end
