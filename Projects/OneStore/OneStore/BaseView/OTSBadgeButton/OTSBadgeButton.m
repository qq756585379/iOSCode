//
//  OTSBadgeButton.m
//  OneStoreCommon
//
//  Created by chaoyao on 16/5/27.
//  Copyright © 2016年 OneStoreCommon. All rights reserved.
//

#import "OTSBadgeButton.h"
#import "OTSColor.h"
#import "OTSFont.h"

@interface OTSBadgeButton()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation OTSBadgeButton

#pragma mark - set & get
- (void)setBadgeCount:(NSNumber *)badgeCount {
    _badgeCount = badgeCount;
    [self configBadgeWithCount:badgeCount];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    [self setupBadgeStyle];
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    _badgeBgColor = badgeBgColor;
    [self setupBadgeStyle];
}

- (void)setBadgeEdgeInsets:(UIEdgeInsets)badgeEdgeInsets {
    _badgeEdgeInsets = badgeEdgeInsets;
    [self configBadgeWithCount:_badgeCount];
}

- (void)configBadgeWithCount:(NSNumber *)count {
    if (!_badgeTextColor) {
        _badgeTextColor = [OTSColor red];
    }
    if (!_badgeBgColor) {
        _badgeBgColor = [OTSColor allWhite];
    }
    
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
    }
    _badgeLabel.text = [NSString stringWithFormat:@"%@",count.intValue > 99 ? @"99+" : count];
    if (count.integerValue <= 99) {
        _badgeLabel.font = [OTSFont otsNumberFontOfSize:10];
    }
    else {
        _badgeLabel.font = [OTSFont otsNumberFontOfSize:8.f];
    }
    
    int vertical = self.badgeEdgeInsets.top - self.badgeEdgeInsets.bottom;
    int horizontal = self.badgeEdgeInsets.left - self.badgeEdgeInsets.right;
    
    [_badgeLabel setFrame:CGRectMake(self.bounds.size.width - 7 + horizontal, vertical - 6, 18, 18)];
    [self setupBadgeStyle];
    [self addSubview:_badgeLabel];
    
    _badgeLabel.hidden = count.intValue == 0;
    if (self.hiddenBadge) {
        _badgeLabel.hidden = YES;
    }
}

- (void)setupBadgeStyle {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
    }
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.backgroundColor = _badgeBgColor;
    _badgeLabel.textColor = _badgeTextColor;
    _badgeLabel.clipsToBounds = YES;
    _badgeLabel.layer.cornerRadius = _badgeLabel.bounds.size.width > 25 ? 8 : _badgeLabel.bounds.size.width / 2;
}

@end
