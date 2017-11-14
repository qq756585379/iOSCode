//
//  MHNavBarMenu.m
//  MiHome
//
//  Created by CoolKernel on 7/17/16.
//  Copyright © 2016 小米移动软件. All rights reserved.
//
#import "MHNavBarMenu.h"
#import <pop/POPSpringAnimation.h>
#import <Masonry/Masonry.h>

#define ITEM_IMAGE_SIZE CGSizeMake(22, 22)

void changeHeightForView(UIView *view, CGFloat height)
{
    CGRect rect = view.frame;
    rect.size.height = height;
    view.frame = rect;
}

@implementation MHNavBarMenuItem

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.titleColor = UIColorFromRGB(0x4a4a4a);
        self.titleFont = [UIFont systemFontOfSize:17.0f];
    }
    return self;
}

@end

#pragma mark - cell
@interface MHNavigationBarMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) MHNavBarMenuItem *model;
@property (nonatomic, assign) BOOL isSupportIcon;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation MHNavigationBarMenuTableViewCell

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

@interface MHNavigationBarMenu () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIView *maskView;// 遮罩
@property (nonatomic, strong) UIView *contentView;// 内容
@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MHNavigationBarMenu

- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width {
    self = [super init];
    if (self) {
        _items = [NSArray array];
        _separatorColor = UIColorFromRGB(0xe8e8e8);
        _rowHeight = ITEM_IMAGE_SIZE.height +  26;
        _triangleFrame = CGRectMake(width - 33, 0, 18, 14);
        
        // 背景
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = .2f;
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        // 内容
        self.origin = origin;
        self.width = width;
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5)];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        // 三角形
        [self _applytriangleView];
        
        // item
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.triangleFrame) + 5, width, self.rowHeight * self.items.count) style:UITableViewStylePlain];
        [self.tableView registerClass:[MHNavigationBarMenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MHNavigationBarMenuTableViewCell class])];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.layer.cornerRadius = 2;
        self.tableView.tableFooterView = [[UIView alloc] init];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHNavigationBarMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHNavigationBarMenuTableViewCell class])];
    cell.model = self.items[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss];
    if (self.didSelectMenuItem) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.didSelectMenuItem(self, self.items[indexPath.row]);
        });
    }
}

- (void)_applytriangleView {
    if (self.triangleView == nil) {
        self.triangleView = [[UIView alloc] init];
        self.triangleView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.triangleView];
    }
    self.triangleFrame = CGRectMake(CGRectGetMinX(self.triangleFrame), 5, CGRectGetWidth(self.triangleFrame), CGRectGetHeight(self.triangleFrame));
    self.triangleView.frame = self.triangleFrame;
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, CGRectGetWidth(self.triangleFrame) / 2.0, 0);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 0, CGRectGetHeight(self.triangleFrame));
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, CGRectGetWidth(self.triangleFrame), CGRectGetHeight(self.triangleFrame));
    shaperLayer.path = path;
    self.triangleView.layer.mask = shaperLayer;
}

#pragma mark - setter
- (void)setItems:(NSArray *)items {
    _items = items;
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5);
    changeHeightForView(self.tableView, self.rowHeight * self.items.count);
    [self.tableView reloadData];
}

- (void)settriangleFrame:(CGRect)triangleFrame {
    _triangleFrame = triangleFrame;
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5);
    changeHeightForView(self.tableView, self.rowHeight * self.items.count);
    [self _applytriangleView];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.tableView.separatorColor = separatorColor;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5);
    changeHeightForView(self.tableView, self.rowHeight * self.items.count);
    [self.tableView reloadData];
}

#pragma mark - public
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.contentView];
    //    self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.contentView.alpha = 0.0f;
    self.maskView.alpha = .0f;
    [UIView animateWithDuration:.35 animations:^{
        self.contentView.alpha = 1.0;
        //        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.maskView.alpha = .2f;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.15 animations:^{
        //        self.contentView.transform = CGAffineTransformMakeScale(.5f, .5f);
        self.contentView.alpha = 0.0f;
        self.maskView.alpha = .0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.maskView removeFromSuperview];
            [self.contentView removeFromSuperview];
        }
    }];
}

@end

@interface MHTopPullMenu() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;// 遮罩
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *contentView;// 内容
@end

#define TopHeight 	 85
#define FooterHeight 10

@implementation MHTopPullMenu

- (instancetype)initWithMenu{
    if (self = [super init]) {
        _items = [NSArray array];
        _rowHeight = ITEM_IMAGE_SIZE.height + 26;
        // 背景
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = .2f;
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.rowHeight * self.items.count + TopHeight + FooterHeight)];
        self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //取消按钮
        UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"MiHomeUI.bundle/navi_closed_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [dismiss setImage:image forState:UIControlStateNormal];
        [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:dismiss];
        
        WEAK_SELF
        [dismiss mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(30);
        }];
        
        // item
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, self.rowHeight * self.items.count + FooterHeight)
                                                      style:UITableViewStylePlain];
        [self.tableView registerClass:[MHNavigationBarMenuTableViewCell class]
               forCellReuseIdentifier:NSStringFromClass([MHNavigationBarMenuTableViewCell class])];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.tableView];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        line.backgroundColor = UIColorFromRGB(0xE1E1E1);
        self.tableView.tableHeaderView = line;
    }
    return self;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    changeHeightForView(self.tableView, self.rowHeight * self.items.count + FooterHeight);
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + TopHeight + FooterHeight);
    [self.tableView reloadData];
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    changeHeightForView(self.tableView, self.rowHeight * self.items.count + FooterHeight);
    changeHeightForView(self.contentView, self.rowHeight * self.items.count + TopHeight + FooterHeight);
    [self.tableView reloadData];
}

#pragma mark - public
- (void)show {
    if (_showing) return;
    self.showing = YES;
//    [self userInteraction:NO];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, (self.rowHeight * self.items.count + TopHeight + FooterHeight)/2-5);
    self.contentView.center = CGPointMake(center.x, -center.y);
    [self.maskView removeFromSuperview];
    [self.contentView removeFromSuperview];
    [window addSubview:self.maskView];
    [window addSubview:self.contentView];
    self.maskView.alpha = .0f;

    WEAK_SELF
    [self animationFromValue:CGPointMake(center.x, -center.y) toValue:center completion:^{
        [weakSelf userInteraction:YES];
    }];
    [UIView animateWithDuration:.35 animations:^{
        weakSelf.maskView.alpha = .2f;
    }];
}

- (void)dismiss:(void (^)(void))finished{
    [self userInteraction:NO];
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, (self.rowHeight * self.items.count + TopHeight + FooterHeight)/2);
	WEAK_SELF
    [self animationFromValue:center toValue:CGPointMake(center.x, -center.y) completion:^{
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHNavigationBarMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHNavigationBarMenuTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    cell.model = self.items[indexPath.row];
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
        STRONG_SELF
        if (self.didSelectMenuItem) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.didSelectMenuItem(self, self.items[indexPath.row]);
            });
        }
    }];
}

@end

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


