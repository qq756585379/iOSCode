//
//  Promotion.m
//  OneStore
//
//  Created by huang jiming on 13-8-8.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "GrouponPromotion.h"

@implementation GrouponPromotion

/**
 *  功能:价格促销的名称
 */
- (NSString *)promotionName
{
    int contentType = self.contentType.intValue;
    NSString *promotionName;
    if (contentType == 1) {
        promotionName = [NSString stringWithFormat:@"单品第%d件打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 2) {
        promotionName = [NSString stringWithFormat:@"单品满%d件每件打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 3) {
        promotionName = [NSString stringWithFormat:@"单品满%d件送%d件", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 4) {
        promotionName = [NSString stringWithFormat:@"全场满%d元减%d元", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 5) {
        promotionName = [NSString stringWithFormat:@"全场满%d元送赠品", self.conditionValue.intValue];
    } else if (contentType == 6) {
        promotionName = [NSString stringWithFormat:@"全场满%d元可换购", self.conditionValue.intValue];
    } else if (contentType == 7) {
        promotionName = [NSString stringWithFormat:@"满%d件减%d元", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 8) {
        promotionName = [NSString stringWithFormat:@"满%d元减%d元", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 9) {
        promotionName = [NSString stringWithFormat:@"满%d件打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 10) {
        promotionName = [NSString stringWithFormat:@"满%d元打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 11) {
        promotionName = [NSString stringWithFormat:@"满%d件送赠品", self.conditionValue.intValue];
    } else if (contentType == 12) {
        promotionName = [NSString stringWithFormat:@"满%d元送赠品", self.conditionValue.intValue];
    } else if (contentType == 13) {
        promotionName = [NSString stringWithFormat:@"满%d件可换购", self.conditionValue.intValue];
    } else if (contentType == 14) {
        promotionName = [NSString stringWithFormat:@"满%d元可换购", self.conditionValue.intValue];
    } else if (contentType == 15) {
        promotionName = [NSString stringWithFormat:@"%d元%d件", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 16) {
        promotionName = [NSString stringWithFormat:@"%d件最高价打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 17) {
        promotionName = [NSString stringWithFormat:@"%d件最低价打%d折", self.conditionValue.intValue, self.contentValue.intValue];
    } else if (contentType == 18) {
        promotionName = @"landing page 促销";
    } else {
        promotionName = @"促销活动";
    }
    
    return promotionName;
}

@end
