//
//  CategoryADSDataVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryADSContainersVO.h"

@interface CategoryADSDataVO : NSObject

@property(nonatomic, strong)NSArray<CategoryADSContainersVO *> *containers;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSNumber *nid;
@property(nonatomic, strong)NSNumber *type;
@property(nonatomic, strong)NSNumber *size;

@end
