//
//  OTSListSearchBarDelegate.m
//  OneStore
//
//  Created by 韩佚 on 16/5/18.
//  Copyright © 2016年 Songyi. All rights reserved.
//

#import "OTSListSearchBar.h"
#import "PureLayout.h"
#import "OTSSearchBarWordView.h"
#import "OTSColor.h"

@interface OTSListSearchBar() <UISearchBarDelegate, OTSSearchBarWordViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView; // SearchBarWordView 的容器

@property (nonatomic, strong) NSMutableArray<OTSSearchBarWordView *> *wordViewArray; // 当前显示的 SearchBarWordView 数组

@property (nonatomic, strong) UITextField *textField; // UISearchBar 中的 textField

@property (nonatomic, strong) UIColor *textFieldColor; // 纪录 textField 文字颜色

@end

@implementation OTSListSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    self.wordSwitch = NO;
    [self.layer setCornerRadius:5.0f];
    [self setClipsToBounds:YES];
    [self.layer setBorderColor:[OTSColor colorWithRGB:0xe0e0e0].CGColor];
    [self.layer setBorderWidth:1.0f];
    [self setTintColor:[OTSColor colorWithRGB:0x757575]];
    [self setBarStyle:UIBarStyleBlackOpaque];// 搜索框样式

    UIImage *clearImg = [self imageWithColor:[OTSColor colorWithRGB:0xeeeeee] andHeight:30.0f];
    [self setBackgroundImage:clearImg];
    [self setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
    self.placeholder = @"搜索商品";

    self.textField = [self valueForKey:@"_searchField"];
    [self.textField.leftView setHidden:YES];
    [self.textField setTextColor:[OTSColor colorWithRGB:0x757575]];
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OTSSB_icon_search"]];
    if ([UIDevice currentDevice].systemVersion.floatValue >= (8.0)) {
        searchIcon.frame = CGRectMake(5, 8, 12, 12);
    }else{
        searchIcon.frame = CGRectMake(8, 8, 14, 14);
    }
    [self addSubview:searchIcon];
    
    [self addSubview:self.scrollView];
    [self.scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.textField withOffset:0];
    [self.scrollView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.textField withOffset:25];
    [self.scrollView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.textField withOffset:-30];
    [self.scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.textField withOffset:0];
    
    // 设置清除内容按钮的图标
    [self setImage:[UIImage imageNamed:@"delete_icon_04"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"delete_icon_04"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    
    // 设置 wordView 开始时相对于 textField 的位置
    self.wordViewLeftgap = 5;
}

- (void)checkWord:(NSString *)keyWord {
    if (!self.isWordSwitch) {
        return;
    }
    
    [self resignFirstResponder];
    [self setTextHidden:YES];
    [self clearWordArray];
    NSArray *keyWordArray = [keyWord componentsSeparatedByString:@" "];
    NSMutableArray *mArr = @[].mutableCopy;
    for (NSString *str in keyWordArray) {
        NSString *filterStr =  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (filterStr.length > 0) {
            [mArr addObject:filterStr];
        }
    }
    if (mArr.count > 1) {
         OTSSearchBarWordView *lastWordView = nil;
        for (NSInteger index = 0; index < mArr.count; index++) {
            OTSSearchBarWordView *wordView = [[OTSSearchBarWordView alloc] initWithFrame:CGRectZero];
            wordView.delegate = self;
            [self.wordViewArray addObject:wordView];
            [wordView updateWordLabelWith:[mArr objectAtIndex:index]];
            wordView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.scrollView addSubview:wordView];
            [wordView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            if (lastWordView == nil) {
                [wordView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.wordViewLeftgap];
            }else{
                [wordView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:lastWordView withOffset:5];
            }
            lastWordView = wordView;
        }
        [self.scrollView layoutSubviews];
        [self layoutSubviews];
    } else {
        [self setTextHidden:NO];
    }
}

- (void)restoreSearchWord {
    [self clearWordArray];
    [self setTextHidden:NO];
}

- (void)clearWordArray {
    if (self.wordViewArray.count > 0) {
        for (OTSSearchBarWordView *wordView in self.wordViewArray) {
            [wordView removeFromSuperview];
        }
    }
    self.wordViewArray = @[].mutableCopy;
}

- (void)setTextHidden:(BOOL)isHidden {
    if (isHidden) {
        if (!self.textFieldColor) {
            self.textFieldColor = self.textField.textColor;
        }
        self.textField.textColor = [UIColor clearColor];
    } else {
        self.textField.textColor = self.textFieldColor;
        self.textFieldColor = nil;
    }
}

- (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - property
- (NSMutableArray<OTSSearchBarWordView *> *)wordViewArray {
    if (!_wordViewArray) {
        _wordViewArray = @[].mutableCopy;
    }
    return _wordViewArray;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
    }
    return _scrollView;
}

#pragma mark - SearchBarWordViewDelegate
- (void)wordView:(OTSSearchBarWordView *)wordView clearButtonClick:(UIButton *)clearButton {
    NSMutableString *searchText = @"".mutableCopy;
    NSInteger index = [self.wordViewArray indexOfObject:wordView];
    [wordView removeFromSuperview];
    [self.wordViewArray removeObject:wordView];
    if (self.wordViewArray.count > 1) {
        for (int i = 0; i < self.wordViewArray.count; ++i) {
            [searchText appendString:[self.wordViewArray[i] getWordViewText]];
            if (!(i == (self.wordViewArray.count - 1))) {
                [searchText appendString:@" "];
            }
        }
    } else if (self.wordViewArray.count == 1) {
        searchText = [[self.wordViewArray firstObject] getWordViewText].mutableCopy;
    } else {
        searchText = @"".mutableCopy;
    }
    self.text = searchText;
    [self checkWord:searchText.copy];
    
    if ([self.delegate respondsToSelector:@selector(wordView:clearButtonClick:index:)]) {
        [self.delegate wordView:wordView clearButtonClick:clearButton index:index];
    }
}

#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    OTSSearchBarWordView *view = [self.wordViewArray lastObject];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), self.scrollView.bounds.size.height);
}

@end
