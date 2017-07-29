//
//  UserVO.m
//  OneStore
//
//  Created by dong yiming on 13-1-8.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "GrouponUserVO.h"


@implementation GrouponUserVO

@dynamic username;
@dynamic password;
@dynamic amount;
@dynamic boughtTimes;
@dynamic cocode;
@dynamic couponCount;
@dynamic email;
@dynamic messageCount;
@dynamic pictureUrl;
@dynamic points;
@dynamic userId;
@dynamic userMobile;
@dynamic vip;
@dynamic userPhone;
@dynamic cardAmount;
@dynamic availableAmount;
@dynamic frozenAmount;
@dynamic userRealName;
@dynamic accountType;
@synthesize enduserPoint;
@synthesize cardNum;
@synthesize availableCardAmount;
@synthesize frozenCardAmount;
@synthesize favoriteCount;
@synthesize availablePoint;
@synthesize frostPoint;
@synthesize expiredPoint;
@synthesize isSignToday;
@synthesize noUsedCardNum;
- (void)updateWithUserVO:(GrouponUserVO *)aUserVO
{
    if (aUserVO)
    {
        self.username = aUserVO.username;
        self.password = aUserVO.password;
        self.amount = aUserVO.amount;
        self.boughtTimes = aUserVO.boughtTimes;
        self.cocode = aUserVO.cocode;
        self.couponCount = aUserVO.couponCount;
        self.email = aUserVO.email;
        self.messageCount = aUserVO.messageCount;
        self.pictureUrl = aUserVO.pictureUrl;
        self.points = aUserVO.points;
        self.userId = aUserVO.userId;
        self.userMobile = aUserVO.userMobile;
        self.vip = aUserVO.vip;
        self.userPhone = aUserVO.userPhone;
        self.cardAmount = aUserVO.cardAmount;
        self.availableAmount = aUserVO.availableAmount;
        self.frozenAmount = aUserVO.frozenAmount;
        self.userRealName = aUserVO.userRealName;
        self.accountType = aUserVO.accountType;
        self.cardNum = aUserVO.cardNum;
        self.availableCardAmount = aUserVO.availableCardAmount;
        self.frozenCardAmount = aUserVO.frozenCardAmount;
        self.availablePoint = aUserVO.availablePoint;
        self.frostPoint = aUserVO.frostPoint;
        self.expiredPoint = aUserVO.expiredPoint;
        self.favoriteCount = aUserVO.favoriteCount;
        self.isSignToday = aUserVO.isSignToday;
		self.noUsedCardNum = aUserVO.noUsedCardNum;
    }
}

- (BOOL)isHaveGiftCard
{
	if (self.noUsedCardNum.integerValue > 0) {
		return YES;
	}
	return NO;
}
@end
