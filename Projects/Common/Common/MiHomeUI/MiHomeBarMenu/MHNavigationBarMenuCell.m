//
//  MHNavigationBarMenuCell.m
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MHNavigationBarMenuCell.h"
#import <Masonry/Masonry.h>

@implementation MHNavigationBarMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isSupportIcon = YES;
        [self buildViews];
    }
    return self;
}

- (void)buildViews {
    WEAK_SELF
    self.itemTitleLabel = [[UILabel alloc] init];
    self.itemTitleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.itemTitleLabel.textColor = UIColorFromRGB(0x4a4a4a);
    [self.contentView addSubview:self.itemTitleLabel];
    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    line.backgroundColor = UIColorFromRGB(0xE1E1E1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.6);
    }];
}

- (void)setModel:(MHNavBarMenuItem *)model {
    self.itemTitleLabel.text = model.title;
    self.itemTitleLabel.textColor = model.titleColor;
    self.itemTitleLabel.font = model.titleFont;
}

@end

