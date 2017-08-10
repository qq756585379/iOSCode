//
//  GrouponAbroadBuyOut.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponAbroadBuyOut : NSObject

@property(nonatomic, strong) NSNumber * isAbroadBuy;//是否海购
@property(nonatomic, assign) double abroadBuyFreeTax; //免税额
@property(nonatomic, strong) NSString *abroadBuyCountryName; //生产国
@property(nonatomic, assign) double abroadBuyRate;//税率
@property(nonatomic, assign) double abroadBuyTax; //单个团购商品的进口税
@property(nonatomic, assign) NSInteger seaBuyMaxLimit; //海购商品限制
@property (nonatomic, strong) NSNumber *deliveryType; /// 出货方式 ：【1：直邮】【2：保税区出货】【其他：普通商品】
@property (nonatomic, strong) NSString *nationalFlagPic; // 产地国旗图片
@property (nonatomic, strong) NSString *departurePlace; // 发货地
@property (nonatomic, strong) NSString *abroadChinaZone; // 1 上海 2 广州

@end
