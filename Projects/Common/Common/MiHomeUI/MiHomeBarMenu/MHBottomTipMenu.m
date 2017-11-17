//
//  MHBottomTipMenu.m
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MHBottomTipMenu.h"
#import <pop/POPSpringAnimation.h>
#import <Masonry/Masonry.h>

void changeHeightForView(UIView *view, CGFloat height)
{
    CGRect rect = view.frame;
    rect.size.height = height;
    view.frame = rect;
}

#pragma mark - cell
@interface MHBottomMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) MHNavBarMenuItem *model;
@property (nonatomic, assign) BOOL isSupportIcon;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation MHBottomMenuTableViewCell

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
        make.left.equalTo(weakSelf).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    line.backgroundColor = UIColorFromRGB(0xE1E1E1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(15);
        make.right.mas_equalTo(weakSelf).offset(-15);
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(0.6);
    }];
}

#pragma mark - setter
- (void)setModel:(MHNavBarMenuItem *)model {
    if (self.isSelected) {
        self.itemTitleLabel.text = [NSString stringWithFormat:@"> %@", model.title];
        self.itemTitleLabel.textColor = UIColorFromRGB(0x3fb57d);
    } else {
        self.itemTitleLabel.text = [NSString stringWithFormat:@"    %@", model.title];
        self.itemTitleLabel.textColor = model.titleColor;
    }
    self.itemTitleLabel.font = model.titleFont;
}

@end

@interface MHBottomTipMenu ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;// 遮罩
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *contentView;// 内容
@end

#define Top  0
#define Footer 0
#define ITEM_IMAGE_SIZE CGSizeMake(22, 22)

@implementation MHBottomTipMenu

- (instancetype)initWithMenu{
    if (self = [super init]) {
        _items = [NSArray array];
        _rowHeight = ITEM_IMAGE_SIZE.height + 26;
        // 背景
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = .2f;
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        // item
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView registerClass:[MHBottomMenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MHBottomMenuTableViewCell class])];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.tableView];
        
        WEAK_SELF
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(weakSelf.contentView);
        }];
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        header.backgroundColor = UIColorFromRGB(0xE1E1E1);
        self.tableView.tableHeaderView = header;
        
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        footer.backgroundColor = UIColorFromRGB(0xE1E1E1);
        self.tableView.tableFooterView = footer;
    }
    return self;
}

- (void)updatePosition{
    CGFloat height = self.rowHeight * self.items.count + Top + Footer;
    self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHBottomMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHBottomMenuTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    MHNavBarMenuItem *model = self.items[indexPath.row];
    cell.isSelected = NO;
    if (self.selectedItem) {
        if ([model.title isEqualToString:self.selectedItem.title]) {
            cell.isSelected = YES;
        }
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isSupportIcon = NO;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WEAK_SELF
    [self dismiss:^{
        if (weakSelf.didSelectMenuItem) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.didSelectMenuItem(weakSelf, weakSelf.items[indexPath.row]);
            });
        }
    }];
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self updatePosition];
    changeHeightForView(self.tableView, self.rowHeight * self.items.count + Footer);
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + Top + Footer);
    [self.tableView reloadData];
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    [self updatePosition];
    changeHeightForView(self.tableView, self.rowHeight * self.items.count + Footer);
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + Top + Footer);
    [self.tableView reloadData];
}

#pragma mark - public
- (void)show {
    if (_showing) return;
    self.showing = YES;
    [self userInteraction:NO];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat height = self.rowHeight * self.items.count + Top + Footer;
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - height/2 + self.contentView.bounds.size.height/2);
    self.contentView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - height/2);
    
    [self.maskView removeFromSuperview];
    [self.contentView removeFromSuperview];
    [window addSubview:self.maskView];
    [window addSubview:self.contentView];
    self.maskView.alpha = .0f;
    WEAK_SELF
    [self animationFromValue:center toValue:self.contentView.center completion:^{
        [weakSelf userInteraction:YES];
    }];
    [UIView animateWithDuration:.2 animations:^{
        weakSelf.maskView.alpha = .2f;
    }];
}

- (void)dismiss:(void (^)(void))finished{
    [self userInteraction:NO];
    CGPoint center = self.contentView.center;
    WEAK_SELF
    [self animationFromValue:center toValue:CGPointMake(center.x, center.y + self.contentView.bounds.size.height) completion:^{
        [weakSelf userInteraction:YES];
        [weakSelf.contentView removeFromSuperview];
        weakSelf.showing = NO;
        if (finished) {
            finished();
        }
    }];
    
    [UIView animateWithDuration:.15 animations:^{
        weakSelf.maskView.alpha = .0f;
    } completion:^(BOOL finished) {
        [weakSelf.maskView removeFromSuperview];
    }];
}

- (void)setSelectedItem:(MHNavBarMenuItem *)selectedItem{
    _selectedItem = selectedItem;
    [self.tableView reloadData];
}

- (void)dismiss {
    [self dismiss:nil];
}

- (void)userInteraction:(BOOL)allow{
    self.contentView.userInteractionEnabled = allow;
    self.maskView.userInteractionEnabled = allow;
}

- (void)animationFromValue:(CGPoint)fromValue toValue:(CGPoint)toValue completion:(void(^)(void))completion{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:fromValue];
    animation.toValue = [NSValue valueWithCGPoint:toValue];
    [animation setCompletionBlock:^(POPAnimation *p, BOOL f) {
        if (completion) {
            completion();
        }
    }];
    [self.contentView pop_addAnimation:animation forKey:nil];
}

@end
