//
//  MHNavigationBarMenuCell.h
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHNavBarMenuItem.h"

@interface MHNavigationBarMenuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) MHNavBarMenuItem *model;
@property (nonatomic, assign) BOOL isSupportIcon;
@property (nonatomic, assign) BOOL isSelected;

@end
