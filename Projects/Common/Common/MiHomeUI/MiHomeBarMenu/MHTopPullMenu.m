//
//  MHTopPullMenu.m
//  Common
//
//  Created by 杨俊 on 2017/11/15.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MHTopPullMenu.h"
#import <Masonry/Masonry.h>
#import <pop/POPSpringAnimation.h>
#import <BlocksKit/UIView+BlocksKit.h>
#import "MHNavigationBarMenuCell.h"
#import "UIView+frame.h"

#define TopHeight      	85
#define FooterHeight 	10
#define ITEM_IMAGE_SIZE CGSizeMake(22, 22)

@interface MHTopPullMenu() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *contentView;// 内容
@property (nonatomic,   copy) didSelectMenuItem aBlock;
@end

@implementation MHTopPullMenu

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self __buildUpUI];
    }
    return self;
}

-(void)__buildUpUI{
    _items = [NSArray array];
    _rowHeight = ITEM_IMAGE_SIZE.height + 26; //默认的行高
    
    self.backgroundColor = [UIColor blackColor];
    self.frame = [UIScreen mainScreen].bounds;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.rowHeight * self.items.count + TopHeight + FooterHeight)];
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //取消按钮
    UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    dismiss.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:dismiss];
    [self.contentView addSubview:self.tableView];
    
    WEAK_SELF
    [dismiss mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.top.mas_equalTo(self.contentView).offset(30);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.top.mas_equalTo(self.contentView).offset(TopHeight);
        make.right.left.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)showWithBlock:(didSelectMenuItem)aBlock{
    self.aBlock = aBlock;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, (self.rowHeight * self.items.count + TopHeight + FooterHeight)/2-5);
    self.contentView.center = CGPointMake(center.x, -center.y);
    [self addSubview:self.contentView];
    [self.tableView reloadData];
    
    WEAK_SELF
    [self animationFromValue:CGPointMake(center.x, -center.y) toValue:center completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [weakSelf userInteraction:YES];
        });
    }];
    
    [UIView animateWithDuration:.35 animations:^{
        weakSelf.alpha = .2f;
    }];
}

- (void)setItems:(NSArray *)items{
    _items = items;
    self.contentView.height = self.rowHeight * self.items.count + TopHeight + FooterHeight;
    [self.tableView reloadData];
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    self.contentView.height = self.rowHeight * self.items.count + TopHeight + FooterHeight;
    [self.tableView reloadData];
}


- (void)dismiss:(void (^)(void))finished{
    //    [self userInteraction:NO];
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, (self.rowHeight * self.items.count + TopHeight + FooterHeight)/2);
    
    WEAK_SELF
    [self animationFromValue:center toValue:CGPointMake(center.x, -center.y) completion:^{
        //        [weakSelf userInteraction:YES];
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

//- (void)userInteraction:(BOOL)allow{
//    self.contentView.userInteractionEnabled = allow;
//    self.maskView.userInteractionEnabled = allow;
//}

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
    MHNavigationBarMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHNavigationBarMenuCell class])];
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
//    [self dismiss:^{
//        STRONG_SELF
//        if (self.didSelectMenuItem) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.didSelectMenuItem(self, self.items[indexPath.row]);
//            });
//        }
//    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[MHNavigationBarMenuCell class]
           forCellReuseIdentifier:NSStringFromClass([MHNavigationBarMenuCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        line.backgroundColor = UIColorFromRGB(0xE1E1E1);
        _tableView.tableHeaderView = line;
    }
    return _tableView;
}

@end
