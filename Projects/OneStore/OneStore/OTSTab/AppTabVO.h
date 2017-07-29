//
//  AppTabVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTabItemVO : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *redPoint;
@property (nonatomic, strong) NSString *iconOff;
@property (nonatomic, strong) NSString *iconOn;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *viewed;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSNumber *showWord; //是否显示tabbar的title
@end



@interface AppTabVO : NSObject
@property (nonatomic, strong) NSArray<AppTabItemVO *> *items;
@end
