//
//  PhoneTabBarItem.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneTabBarItem.h"

@implementation PhoneTabBarItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textColor = [OTSColor colorWithRGB:0x757575];
        self.imageInsets = UIEdgeInsetsMake(0, 0, 6, 0);
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        if (self.defaultVO.selectHexColor) {
            self.titleLabel.textColor = [OTSColor hex:self.defaultVO.selectHexColor];
        }else {
            self.titleLabel.textColor = [OTSColor colorWithRGB:0xff3c25];
        }
    }else {
        self.titleLabel.textColor = [OTSColor colorWithRGB:0x757575];
    }
}

- (void)setDefaultVO:(PhoneTabBarItemVO *)defaultVO{
    _defaultVO = defaultVO;
    self.title = _defaultVO.title;
    self.image = _defaultVO.image;
    self.selectedImage = _defaultVO.selectedImage;
    self.hostString = _defaultVO.hostString;
    self.showWord = defaultVO.showWord;
}

- (void)updateWithItemVO:(AppTabItemVO *)aVO{
    if (aVO) {
        if (self.title.length) {
            self.title = aVO.name;
        }
        if (self.title.length > 5) {
            self.title = [self.title substringToIndex:5];
        }
        if (!aVO.viewed.boolValue && self.showIndicate != aVO.redPoint.boolValue) {
            self.showIndicate = aVO.redPoint.boolValue;
        }
    }else {
        self.title = self.defaultVO.title;
        self.showIndicate = NO;
    }
    [self updateImageWithItemVO:aVO];
}

- (void)updateImageWithItemVO:(AppTabItemVO *)aVO{
    self.vo = aVO;
    if (!self.vo) {
        self.title = self.defaultVO.title;
        self.image = self.defaultVO.image;
        self.selectedImage = self.defaultVO.selectedImage;
        self.hostString = self.defaultVO.hostString;
        self.showWord = YES;
    } else {
        self.showWord = aVO.showWord.boolValue;
    }
    
    if (aVO.iconOff) {
        WEAK_SELF;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:aVO.iconOff] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            STRONG_SELF;
            if ( !error && finished) {
                self.image = image;
            } else {
                self.showWord = YES;
            }
        }];
    }
    if (aVO.iconOn) {
        WEAK_SELF;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:aVO.iconOn] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            STRONG_SELF;
            if ( ! error && finished) {
                self.selectedImage = image;
            } else {
                self.showWord = YES;
            }
        }];
    }
}

- (BOOL)shouldUpdateWithItemVO:(AppTabItemVO *)aVO{
    if (!aVO.updateTime) {
        return NO;
    }
    if ([self.vo.updateTime isEqualToString:aVO.updateTime]) {
        return NO;
    }
    return YES;
}

- (void)setShowIndicate:(BOOL)showIndicate{
    if (self.showIndicate && !showIndicate) {
        self.vo.viewed = @1;
        [self postNotification:@"updateTabVO" withObject:self];
    }
    [super setShowIndicate:showIndicate];
}

@end
