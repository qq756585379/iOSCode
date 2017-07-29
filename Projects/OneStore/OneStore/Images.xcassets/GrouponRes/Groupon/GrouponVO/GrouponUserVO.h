//
//  UserVO.h
//  OneStore
//
//  Created by dong yiming on 13-1-8.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// 用户账户类型
typedef enum {
    kUserAccountNormal = 0      // 普通账号
    , kUserAccountUnion         // 联合账号
} EOTSUserAccountType;


@interface GrouponUserVO : OTSValueObject

@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSNumber *amount;
@property(nonatomic, retain) NSNumber *boughtTimes;
@property(nonatomic, retain) NSString *cocode;
@property(nonatomic, retain) NSNumber *couponCount;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSNumber *messageCount;
@property(nonatomic, retain) NSString *pictureUrl;
@property(nonatomic, retain) NSNumber *points;
@property(nonatomic, retain) NSNumber *userId;
@property(nonatomic, retain) NSString *userMobile;
@property(nonatomic, retain) NSNumber *vip;
@property(nonatomic, retain) NSString *userPhone;
@property(nonatomic, retain) NSString *userRealName;//用户昵称
@property(nonatomic, retain) NSNumber *accountType;//账号类型, 取值为EOTSUserAccountType
@property(nonatomic, retain) NSNumber *enduserPoint;
@property(nonatomic, retain) NSNumber *cardNum;

@property(nonatomic, retain) NSNumber *availableAmount;//账户可用金额
@property(nonatomic, retain) NSNumber *frozenAmount;//账户冻结金额
@property(nonatomic, retain) NSNumber *cardAmount;//账号礼品卡金额
@property(nonatomic, retain) NSNumber *availableCardAmount;//可用礼品卡金额
@property(nonatomic, retain) NSNumber *frozenCardAmount;//冻结礼品卡金额

@property(nonatomic, retain) NSNumber *availablePoint;//用户可用积分
@property(nonatomic, retain) NSNumber *frostPoint;//用户冻结积分
@property(nonatomic, retain) NSNumber *expiredPoint;//用户过期积分

@property(nonatomic, retain) NSNumber *favoriteCount;

@property (nonatomic, retain) NSNumber *isSignToday;//用户今日签到

@property(nonatomic, strong)  NSNumber *noUsedCardNum; //用户未使用礼品卡张数

- (void)updateWithUserVO:(GrouponUserVO *)aUserVO;

/**
 *	功能:是否有电子礼品卡
 *
 *	@return
 */
- (BOOL)isHaveGiftCard;
@end
