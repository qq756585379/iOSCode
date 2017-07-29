//
//  PhoneTabBarItem.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSTabBarItem.h"
#import "AppTabVO.h"
#import "PhoneTabBarItemVO.h"

@interface PhoneTabBarItem : OTSTabBarItem

@property (nonatomic, strong) PhoneTabBarItemVO *defaultVO;
@property (nonatomic, strong) AppTabItemVO *vo;
@property (nonatomic, strong) NSString *hostString;

- (void)updateWithItemVO:(AppTabItemVO *)aVO;
- (void)updateImageWithItemVO:(AppTabItemVO *)aVO;
- (BOOL)shouldUpdateWithItemVO:(AppTabItemVO *)aVO;

@end
