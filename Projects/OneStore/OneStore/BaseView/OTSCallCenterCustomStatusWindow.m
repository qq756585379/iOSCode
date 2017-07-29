//
//  OTSCallCenterCustomStatusWindow.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/19.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSCallCenterCustomStatusWindow.h"
#import "OTSGlobalValue.h"

#define VIEW_HEIGHT 20.f

@interface StatusWindowRootViewController : UIViewController

@end

@implementation StatusWindowRootViewController

- (BOOL)shouldAutorotate{
    if (IS_IPAD_DEVICE) {
        return YES;
    } else {
        return NO;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end

@interface OTSCallCenterCustomStatusWindow()
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UILabel *unReadLabel;
@property (nonatomic, assign) NSInteger unReadCount;
@end

@implementation OTSCallCenterCustomStatusWindow

- (instancetype)init{
    if (self = [super init]) {
        [self setupViews];
        [self observeNotification:OTS_GET_ALL_UNREADNUM];
        [self observeNotification:OTS_CALLCENTER_UPDATE_MESSAGE_COUNT];
        [self observeNotification:OTS_GLOBAL_CAN_SHOW_MESSAGE];
        [self observeNotification:OTS_GLOBAL_SHOW_MESSAGE];
        [self observeNotification:OTS_GLOBAL_HIDEN_MESSAGE];
        
        if(IOS_SDK_LESS_THAN(8.0))//iOS 8以下，转屏监听状态栏； iOS 8 以上跟随window的rootViewController方向
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willUpdateOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateOrientation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        }
    }
    return self;
}

#pragma mark setup
-(void)setupViews{
    self.frame = [UIScreen mainScreen].bounds;
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelStatusBar + 1.f;
    self.rootViewController = [[StatusWindowRootViewController alloc] init];//window的转屏方向跟随rootViewcontroller的view方向
    self.userInteractionEnabled = YES;
    [self addSubview:self.messageButton];
    [self addSubview:self.unReadLabel];
}

#pragma mark Notification Handle
- (void)willUpdateOrientation:(NSNotification*)notification{
    UIInterfaceOrientation newOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    [self handleOrientation:newOrientation];
}

- (void)didUpdateOrientation:(NSNotification*)notification{
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)handleOrientation:(UIInterfaceOrientation)orientation{
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        {
            self.transform = CGAffineTransformIdentity;
        }
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            self.transform = CGAffineTransformMakeRotation(M_PI);
        }
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
            break;
            
        case UIInterfaceOrientationLandscapeRight:
        {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        default:
            break;
    }
}

- (void)setCsrDict:(NSDictionary *)csrDict{
    _csrDict = csrDict;
    [_messageButton setTitle:csrDict[@"csrName"] forState:UIControlStateNormal];
    _unReadCount = [[OTSGlobalValue sharedInstance].chatMessageCount integerValue];
    if (_unReadCount<=99) {
        [_unReadLabel setText:[NSString stringWithFormat:@"(%ld)",(long)_unReadCount]];
        [_unReadLabel setFont:[UIFont systemFontOfSize:12]];
    }else{
        [_unReadLabel setText:@"(99+)"];
        [_unReadLabel setFont:[UIFont systemFontOfSize:10]];
    }
}

#pragma mark window事件处理
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //除了按钮，其他的控件不处理
    CGPoint hitPoint = [_messageButton convertPoint:point fromView:self];
    if ([_messageButton pointInside:hitPoint withEvent:event] && !self.hidden){
        return _messageButton;
    }else{
        return nil;
    }
}

#pragma mark notification
- (void)handleNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:OTS_CALLCENTER_UPDATE_MESSAGE_COUNT]) {
        [self hideMessage];
    } else if ([notification.name isEqualToString:OTS_GLOBAL_CAN_SHOW_MESSAGE]) {
        NSNumber *obj = notification.object;
        BOOL canShow = obj.boolValue;
        self.canShow = canShow;
    } else if ([notification.name isEqualToString:OTS_GLOBAL_SHOW_MESSAGE]) {// 全局展示未读消息
        NSDictionary *dict = notification.object;
        self.csrDict = dict;
        if ([OTSGlobalValue sharedInstance].chatMessageCount.longLongValue > 0) {
            [self showMessage];
        }
    } else if ([notification.name isEqualToString:OTS_GLOBAL_HIDEN_MESSAGE]) {
        [self hideMessage];
    }
}

/**
 *  展现动画
 */
- (void)showMessage{
    if (!self.canShow) return;
    if (!self.hidden) return;
    WEAK_SELF;
    self.hidden = NO;
    self.alpha = 0.01;
    [UIView animateWithDuration:0.3f animations:^{
        STRONG_SELF;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  隐藏动画
 */
- (void)hideMessage{
    if (self.hidden) return;
    WEAK_SELF;
    [UIView animateWithDuration:0.3f animations:^{
        STRONG_SELF;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

/**
 *  进入消息中心
 */
- (void)buttonDidClicked{
//    OTSBITrackerBDPramaVO *VO = [OTSBITrackerBDPramaVO new];
//    VO.w_pt = @"10000";
//    VO.w_tpa = @"6";
//    VO.w_tpi = @"1";
//    [[OTSBITracker sharedInstance] sendTracker:nil fromPage:nil withBD:[VO convertToDictionary]];
    
    if(IS_IPAD_DEVICE){
        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"messagecenter" andParams:nil]]];
    }else{
        [[OTSRouter singletonInstance] routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"messagecenterCustomer" andParams:nil]]];
    }
    [self hideMessage];
}

#pragma mark- Proeprty
- (UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.frame = CGRectMake(self.bounds.size.width-90-29, 0,90, VIEW_HEIGHT);
        _messageButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        _messageButton.userInteractionEnabled = YES;
        _messageButton.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
        [_messageButton setBackgroundImage:[UIImage imageNamed:@"message_element_window"] forState:UIControlStateNormal];
        [_messageButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_messageButton addTarget:self action:@selector(buttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}

- (UILabel *)unReadLabel{
    if (!_unReadLabel) {
        _unReadLabel = [[UILabel alloc] init];
        _unReadLabel.frame = CGRectMake(self.bounds.size.width-29, 0, 29, VIEW_HEIGHT);
        _unReadLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_unReadLabel setFont:[UIFont systemFontOfSize:12]];
        [_unReadLabel setTextAlignment:NSTextAlignmentCenter];
        [_unReadLabel setBackgroundColor:RGB(243, 152, 0)];
        [_unReadLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMessage)]];
    }
    return _unReadLabel;
}

- (void)dealloc{
    [self unobserveAllNotifications];
}

@end
