//
//  GrouponViewVO.h
//  GrouponProject
//
//  Created by meichun on 14-9-29.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponContainerVO.h"

@interface GrouponViewVO : OTSValueObject

@property(nonatomic, strong)NSNumber  *nid;                      //long,页面id，保留字段
@property(nonatomic, strong)NSNumber  *type;           	        //int,页面类型，保留字段
@property(nonatomic, strong)NSNumber  *size;                    //int	广告位数量
@property(nonatomic, strong)NSArray   *containers;              //List<ContainerVO>	广告位
@property(nonatomic, strong)NSString  *name;//
@property(nonatomic, strong)NSString *style;//页面布局样式，”template1” “template2”  “template3”
@property(nonatomic, strong)NSString *rule;//活动规则，注意是html格式

/**
 *  功能:根据日期来区分的活动数据，最多为3天的数据，key的格式为YYYY-MM-DD，object为数组
 */
- (NSMutableDictionary *)activityByDate;

@end
