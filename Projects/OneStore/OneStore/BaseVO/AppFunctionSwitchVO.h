//
//  AppFunctionSwitchVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/28.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFunctionSwitchVO : NSObject

@property(nonatomic, strong)NSString *functionCode; // 模块名称
@property(nonatomic, strong)NSNumber *functionSwitch; //此模块是否开启
@property(nonatomic, strong)NSString *functionValue; //此模块参数

@end
