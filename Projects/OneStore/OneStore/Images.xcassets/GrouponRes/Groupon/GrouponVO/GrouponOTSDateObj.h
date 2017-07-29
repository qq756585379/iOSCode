//
//  OTSDateObj.h
//  GrouponProject
//
//  Created by meichun on 14-9-22.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GrouponContainerVO;

@interface GrouponOTSDateObj : OTSValueObject
@property(nonatomic, strong) NSDateComponents* timeComponents;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, assign) BOOL isPanic;//是否在抢购中

#pragma mark - 团购预热本地提醒
@property(nonatomic, strong) GrouponContainerVO *containerVO;//团购预热栏目

- (BOOL)timeIsEnd;
@end
