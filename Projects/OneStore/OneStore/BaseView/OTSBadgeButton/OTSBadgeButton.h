//
//  OTSBadgeButton.h
//  OneStoreCommon
//
//  Created by chaoyao on 16/5/27.
//  Copyright © 2016年 OneStoreCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSBadgeButton : UIButton

@property (nonatomic,   copy) NSNumber *badgeCount;//未读消息数量
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, assign) BOOL hiddenBadge;
@property (nonatomic, assign) UIEdgeInsets badgeEdgeInsets;

@end
