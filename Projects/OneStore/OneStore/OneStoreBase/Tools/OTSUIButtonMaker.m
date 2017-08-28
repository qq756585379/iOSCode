//
//  OTSUIButtonMaker.m
//  OneStoreFramework
//
//  Created by airspuer on 5/1/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSUIButtonMaker.h"

@interface OTSUIButtonMaker()
@property(nonatomic, strong)UIButton *button;
@end

@implementation OTSUIButtonMaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleFontSize = [UIFont systemFontSize];
        self.titleColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initialization
{
    self.titleFontSize = [UIFont systemFontSize];
    self.titleColor = [UIColor whiteColor];
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.contentEdgeInsets = UIEdgeInsetsZero;
}

- (instancetype)initWithView:(UIView *)aView
{
    self = [super initWithView:aView];
    if (self) {
        [self initialization];
        if ([aView isKindOfClass:[UIButton class]]) {
            self.button = (UIButton*)aView;
        }
    }
    return self;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    [self.button setTitleColor:color forState:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [self.button setImage:image forState:state];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [self.button setBackgroundImage:image forState:state];
}

- (void)install
{
    [super install];
    self.button.titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    if (self.image) {
        [self setImage:self.image forState:UIControlStateNormal];
    }
    if (self.backgroundImage) {
        [self setBackgroundImage:self.backgroundImage forState:UIControlStateNormal];
    }
    self.button.titleEdgeInsets = self.titleEdgeInsets;
    self.button.contentEdgeInsets = self.contentEdgeInsets;
    self.button.imageEdgeInsets = self.imageEdgeInsets;
}

@end
