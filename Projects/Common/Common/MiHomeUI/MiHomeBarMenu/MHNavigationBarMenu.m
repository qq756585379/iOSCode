//
//  MHNavigationBarMenu.m
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MHNavigationBarMenu.h"
#import <pop/POPSpringAnimation.h>
#import "MHNavigationBarMenuCell.h"
#import <Masonry/Masonry.h>
#import "UIView+frame.h"

@interface MHNavigationBarMenu () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIView *maskView;// 遮罩
@property (nonatomic, strong) UIView *contentView;// 内容
@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UITableView *tableView;
@end

#define ITEM_IMAGE_SIZE CGSizeMake(22, 22)

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
        [self.tableView registerClass:[MHNavigationBarMenuCell class] forCellReuseIdentifier:NSStringFromClass([MHNavigationBarMenuCell class])];
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
    MHNavigationBarMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHNavigationBarMenuCell class])];
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
    self.contentView.height = self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5;
    self.tableView.height = self.rowHeight * self.items.count;
    [self.tableView reloadData];
}

- (void)settriangleFrame:(CGRect)triangleFrame {
    _triangleFrame = triangleFrame;
    self.contentView.height = self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5;
    self.tableView.height = self.rowHeight * self.items.count;
  
    [self _applytriangleView];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.tableView.separatorColor = separatorColor;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    self.contentView.height = self.rowHeight * self.items.count + CGRectGetHeight(self.triangleFrame) + 5;
    self.tableView.height = self.rowHeight * self.items.count;
    
    [self.tableView reloadData];
}

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
