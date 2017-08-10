//
//  GrouponAbroadBuyOut.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "GrouponAbroadBuyOut.h"

@implementation GrouponAbroadBuyOut

- (NSInteger)seaBuyMaxLimit
{
    if (self.abroadBuyTax == 0) {
        return 0;
    }
    return self.abroadBuyFreeTax / self.abroadBuyTax;
}

@end
