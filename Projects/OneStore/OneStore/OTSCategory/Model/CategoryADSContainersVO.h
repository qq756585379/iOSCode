//
//  CategoryADSContainersVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomePromotionDetailVO;

@interface CategoryADSContainersVO : NSObject

@property(nonatomic, strong)NSMutableArray<HomePromotionDetailVO *> * ads;
@property(nonatomic, strong)NSDictionary *cds;
@property(nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)NSNumber *order;
@property(nonatomic, strong)NSNumber *size;
@property(nonatomic, strong)NSNumber *type;

@end
