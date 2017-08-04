//
//  SearchBarWordView.m
//  OneStore
//
//  Created by 韩佚 on 16/5/18.
//  Copyright © 2016年 Songyi. All rights reserved.
//

#import "OTSSearchBarWordView.h"
#import "PureLayout.h"
#import "OTSColor.h"

@interface OTSSearchBarWordView()
@property (nonatomic, strong) UILabel  *wordLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIView   *divisionView;
@end

@implementation OTSSearchBarWordView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = [OTSColor colorWithRGB:0x646464];
    }
    return self;
}

- (void)initUI {
    [self.layer setCornerRadius:2.0f];
    [self setClipsToBounds:YES];
    self.alpha = 0.9;
    
    [self addSubview:self.clearButton];
    [self addSubview:self.wordLabel];
    [self addSubview:self.divisionView];
    
    [self.clearButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.clearButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [self.divisionView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.clearButton withOffset:3];
    [self.divisionView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.divisionView autoSetDimensionsToSize:CGSizeMake(1, 13)];
    
    [self.wordLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.wordLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [self.wordLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.clearButton];
    
    [self autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.wordLabel withOffset:-4];
    [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.wordLabel withOffset:4];
}

- (void)updateWordLabelWith:(NSString *)text {
    self.wordLabel.text = text;
}

- (NSString *)getWordViewText {
    return self.wordLabel.text;
}

- (void)clearButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wordView:clearButtonClick:)]) {
        [self.delegate wordView:self clearButtonClick:sender];
    }
}

- (UILabel *)wordLabel {
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _wordLabel.font = [UIFont systemFontOfSize:12];
        _wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _wordLabel.text = @"Macbook";
        _wordLabel.textColor = [OTSColor whiteColor];
    }
    return _wordLabel;
}
- (UIView *)divisionView {
    if (!_divisionView) {
        _divisionView = [[UIView alloc] initWithFrame:CGRectZero];
        _divisionView.backgroundColor = [OTSColor colorWithRGB:0x808080];
    }
    return _divisionView;
}
- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [[UIButton alloc] init];
        [_clearButton setImage:[UIImage imageNamed:@"searchBarWordClear"] forState:UIControlStateNormal];
        _clearButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

@end
