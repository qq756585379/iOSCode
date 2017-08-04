//
//  OTSGifNilView.m
//  OTSCommon
//
//  Created by HUI on 16/6/29.
//  Copyright © 2016年 OTSCommon. All rights reserved.
//

#import "OTSGifNilView.h"
#import "FLAnimatedImage.h"

@interface OTSGifNilView ()
@property (nonatomic, strong) UILabel *nilInfoLabel;
@end

@implementation OTSGifNilView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMainView];
        WEAK_SELF;
        self.nilGifImgView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
            STRONG_SELF;
            [self.nilGifImgView stopAnimating];
        };

    }
    return self;
}

- (void)setupMainView {
    [self addSubview:self.nilGifImgView];
    [self addSubview:self.nilInfoLabel];
    [self addSubview:self.nilHomeBtn];
    
    [self.nilInfoLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:IS_IPAD_DEVICE?90:50];
    [self.nilInfoLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nilInfoLabel autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.nilGifImgView autoSetDimensionsToSize:IS_IPAD_DEVICE?CGSizeMake(200, 200):CGSizeMake(120, 120)];
    [self.nilGifImgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.nilInfoLabel withOffset:-10];
    [self.nilGifImgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.nilHomeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nilInfoLabel withOffset:10];
    [self.nilHomeBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nilHomeBtn autoSetDimensionsToSize:CGSizeMake(80, 25)];
}

#pragma mark - properties
- (UILabel *)nilInfoLabel {
    if (_nilInfoLabel == nil) {
        _nilInfoLabel = [UILabel newAutoLayoutView];
        _nilInfoLabel.font = [OTSFont large];
        _nilInfoLabel.textColor = RGB(117, 117, 117);
        _nilInfoLabel.textAlignment = NSTextAlignmentCenter;
        _nilInfoLabel.text = @"是空哒~快去买买买";
        _nilInfoLabel.numberOfLines = 2;
    }
    return _nilInfoLabel;
}
- (UIButton *)nilHomeBtn {
    if (_nilHomeBtn == nil) {
        _nilHomeBtn = [UIButton newAutoLayoutView];
        _nilHomeBtn.backgroundColor = [UIColor redColor];
        _nilHomeBtn.layer.cornerRadius = 5;
        _nilHomeBtn.layer.masksToBounds = YES;
        _nilHomeBtn.titleLabel.font = [OTSFont large];
        [_nilHomeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nilHomeBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [_nilHomeBtn addTarget:self action:@selector(goToHomePage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nilHomeBtn;
}
- (FLAnimatedImageView *)nilGifImgView {
    if (_nilGifImgView == nil) {
        _nilGifImgView = [FLAnimatedImageView newAutoLayoutView];
    }
    return _nilGifImgView;
}

- (void)setNilInfo:(NSString *)nilInfo gifImgName:(NSString *)gifImgName {
    if (gifImgName.length) {
        NSString *gifPath = [[NSBundle bundleForClass:[self class]] pathForResource:[NSString stringWithFormat:@"nilViewGifs.bundle/%@", gifImgName] ofType:@"gif"];
        FLAnimatedImage *aniImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:gifPath]];
        self.nilGifImgView.animatedImage = aniImage;
    }
    self.nilInfoLabel.text = nilInfo;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (!hidden) {
        [self.nilGifImgView startAnimating];
    }
}

- (void)goToHomePage {
    [[OTSRouter singletonInstance] routerWithUrlString:@"yhd://home"];
}

@end
