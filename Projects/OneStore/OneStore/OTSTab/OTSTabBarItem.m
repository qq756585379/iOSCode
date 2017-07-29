//
//  OTSTabBarItem.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSTabBarItem.h"
#import "PureLayout.h"

@interface OTSTabBarItem ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UIView *indicateView;

@property (nonatomic, strong) NSLayoutConstraint *hConstraint;
@property (nonatomic, strong) NSLayoutConstraint *vConstraint;
@property (nonatomic, strong) NSLayoutConstraint *backgroundWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *backgroundHeightConstraint;
@end

@implementation OTSTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.imageInsets = UIEdgeInsetsZero;
        [self _OTSTabBarItem_setupViews];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressTabbarItem)];
        [self addGestureRecognizer:ges];
    }
    return self;
}

- (void)_OTSTabBarItem_setupViews{
    self.background = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.background.backgroundColor = [UIColor clearColor];
    self.background.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.background];
    
    self.background.translatesAutoresizingMaskIntoConstraints = NO;
    self.hConstraint = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    [self addConstraint:self.hConstraint];
    self.backgroundWidthConstraint = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:24.f];
    [self addConstraint:self.backgroundWidthConstraint];
    
    self.vConstraint = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
    [self addConstraint:self.vConstraint];
    self.backgroundHeightConstraint = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:24.f];
    [self addConstraint:self.backgroundHeightConstraint];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.6];
    [self addSubview:self.titleLabel];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:-4.f]];
    
    self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.backgroundColor = [OTSColor colorWithRGB:0xff3c25];
    self.badgeLabel.font = [UIFont systemFontOfSize:12.f];
    self.badgeLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.badgeLabel.adjustsFontSizeToFitWidth = YES;
    self.badgeLabel.clipsToBounds = YES;
    self.badgeLabel.layer.cornerRadius = 7.f;
    self.badgeLabel.hidden = YES;
    [self addSubview:self.badgeLabel];
    
    self.indicateView = [UIView newAutoLayoutView];
    self.indicateView.backgroundColor = [OTSColor colorWithRGB:0xff3c25];
    self.indicateView.clipsToBounds = YES;
    self.indicateView.layer.cornerRadius = 4.f;
    self.indicateView.hidden = YES;
    [self addSubview:self.indicateView];
    
    self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:3.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:14.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:14.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicateView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:8.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:8.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicateView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:-14.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicateView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:6]];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    OTSTabBarItem *item = [[self alloc] initWithFrame:CGRectZero];
    item.title = title;
    item.image = image;
    item.selectedImage = selectedImage;
    return item;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self _OTSTabBarItem_resizeViews];
}

- (void)setImageInsets:(UIEdgeInsets)imageInsets{
    _imageInsets = imageInsets;
    [self _OTSTabBarItem_resizeViews];
}

- (void)_OTSTabBarItem_resizeViews{
    self.hConstraint.constant = self.imageInsets.left - self.imageInsets.right;
    self.vConstraint.constant = self.imageInsets.top - self.imageInsets.bottom;
    if (!self.isShowWord) {
        self.backgroundHeightConstraint.constant = 49.f;
        self.backgroundWidthConstraint.constant = 64.f;
    } else {
        self.backgroundHeightConstraint.constant = 24.f;
        self.backgroundWidthConstraint.constant = 24.f;
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    self.badgeLabel.text = _badgeValue;
    self.badgeLabel.hidden = !_badgeValue;
    if (_showIndicate && self.badgeLabel.hidden) {
        self.indicateView.hidden = NO;
    }else {
        self.indicateView.hidden = YES;
    }
}

- (void)setShowIndicate:(BOOL)showIndicate{
    _showIndicate = showIndicate;
    if (_showIndicate && self.badgeLabel.hidden) {
        self.indicateView.hidden = NO;
    }else {
        self.indicateView.hidden = YES;
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    if (!self.isSelected) {
        self.background.image = _image;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    if (self.isSelected) {
        self.background.image = _selectedImage;
    }
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    self.background.image = selected ? self.selectedImage : self.image;
}

-(void)setShowWord:(BOOL)showWord{
    _showWord = showWord;
    self.titleLabel.hidden = !showWord;
    self.imageInsets = UIEdgeInsetsMake(0, 0, showWord ? 6 : 0, 0);
    [self _OTSTabBarItem_resizeViews];
}

- (void)onPressTabbarItem{
    if ([self.delegate respondsToSelector:@selector(tabBarItemDidSelectItem:)]) {
        [self.delegate tabBarItemDidSelectItem:self];
    }
}

@end
