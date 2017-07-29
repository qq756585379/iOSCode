//
//  OTSTabBar.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSTabBar.h"
#import "Masonry.h"
#import "NSArray+MASAdditions.h"

@interface OTSTabBar()<OTSTabBarItemDelegate>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation OTSTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.backgroundView = [UIImageView newAutoLayoutView];
    [self addSubview:self.backgroundView];
    [self.backgroundView autoPinEdgesToSuperviewEdges];
    
    self.backgroundImageView = [UIImageView newAutoLayoutView];
    [self.backgroundView addSubview:self.backgroundImageView];
    [self.backgroundImageView autoPinEdgesToSuperviewEdges];
}

- (void)setItems:(NSArray *)items{
    for (id object in items) {
        if (![object isKindOfClass:[OTSTabBarItem class]]) {
            DLog(@"%@ is not kind of OTSTabBarItem",object);
            return ;
        }
    }
    [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _items = [items copy];
    self.selectedItem = _items[0];
    [self __resizeItems];
}

- (void)__resizeItems{
    for (OTSTabBarItem *item in _items) {
        item.tag = [_items indexOfObject:item];
        [self addSubview:item];
        item.delegate = self;
        item.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [_items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
    }];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    self.backgroundImageView.image = backgroundImage;
}

- (void)setSelectedItem:(OTSTabBarItem *)selectedItem{
    if (_selectedItem == selectedItem) {
        _selectedItem.selected = YES;
        return ;
    }
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
    _selectedItem.selected = YES;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTabBar:didSelectItem:)]) {
        [self.delegate customTabBar:self didSelectItem:_items[selectedIndex]];
    }
}

- (NSUInteger)selectedIndex{
    return self.selectedItem.tag;
}

#pragma mark - OTSTabBarItem delegate
- (void)tabBarItemDidSelectItem:(OTSTabBarItem *)item{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTabBar:didSelectItem:)]) {
        [self.delegate customTabBar:self didSelectItem:item];
    }
}

@end
