//
//  OTSPresentController.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSPresentController.h"
#import "PureLayout.h"
#import "CommonDefine.h"
#import "UIView+Util.h"
#import "AppDelegate.h"

@interface OTSPresentController ()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation OTSPresentController

-(UIView *)dimmingView{
    if (!_dimmingView) {
        _dimmingView = [UIView autolayoutView];
        _dimmingView.alpha = 0.f;
        _dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        [_dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDimmingView)]];
    }
    return _dimmingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.dimmingView];
    [self.dimmingView autoPinEdgesToSuperviewEdgesWithInsets:self.dimmingEdge];
}

- (void)onTapDimmingView{
    WEAK_SELF;
    if ([self.pcDelegate respondsToSelector:@selector(shouldDismissPresentationController:)]) {
        STRONG_SELF;
        if (![self.pcDelegate shouldDismissPresentationController:self]) {
            return ;
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }];
}

- (NSTimeInterval)duration{
    if (_duration == 0.f) {
        _duration = .4f;
    }
    return _duration;
}

- (void)presentViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion{
    AppDelegate *app = (id)[UIApplication sharedApplication].delegate;
    if (app.pcWindow.rootViewController.childViewControllers.count) {
        app.pcWindow.hidden = NO;
        [app.pcWindow makeKeyWindow];
    }
    if ([self.pcDelegate respondsToSelector:@selector(willPresentPC:)]) {
        [self.pcDelegate willPresentPC:self];
    }
    //call viewwillappear
    [self callChildVCsViewWillAppear:animated];
    
    WEAK_SELF;
    [UIView animateWithDuration:self.duration animations:^{
        STRONG_SELF;
        self.dimmingView.alpha = 1.f;
        self.animationVC.view.center = CGPointMake(self.animationVC.view.center.x, self.animationVC.view.center.y - self.animationVC.view.bounds.size.height);
        self.animationView.center = CGPointMake(self.animationView.center.x, self.animationView.center.y - self.animationView.bounds.size.height);
    } completion:^(BOOL finished) {
        STRONG_SELF;
        [self didMoveToParentViewController:self.parentViewController];
        [self.animationVC didMoveToParentViewController:self.animationVC.parentViewController];
        
        //call viewdidappear
        [self callChildVCsViewDidAppear:animated];
        
        if ([self.pcDelegate respondsToSelector:@selector(didPresentPC:)]) {
            [self.pcDelegate didPresentPC:self];
        }
        
        if (completion) {
            completion();
        }
    }];
}

- (void)dealFiishedDismissViewControllerAnimated:(BOOL)animated{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    [self.animationVC removeFromParentViewController];
    
    //call viewdiddisappear
    [self callChildVCsViewDidDisappear:animated];
    
    //取消显示pc window
    AppDelegate *app = (id)[UIApplication sharedApplication].delegate;
    if (app.pcWindow.rootViewController.childViewControllers.count == 0) {
        [app.pcWindow endEditing:YES];//隐藏pc的键盘
        app.pcWindow.hidden = YES;
    }
    
    if ([self.pcDelegate respondsToSelector:@selector(didDismissPC:)]) {
        [self.pcDelegate didDismissPC:self];
    }
    
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:animated completion:completion];
    if ([self.pcDelegate respondsToSelector:@selector(willDismissPC:)]) {
        [self.pcDelegate willDismissPC:self];
    }
    [self willMoveToParentViewController:nil];
    
    //call viewwilldisappear
    [self callChildVCsViewWillDisappear:animated];
    if (animated) {
        WEAK_SELF;
        [UIView animateWithDuration:self.duration animations:^{
            STRONG_SELF;
            self.dimmingView.alpha = 0.f;
            self.animationVC.view.center = CGPointMake(self.animationVC.view.center.x, self.animationVC.view.center.y + self.animationVC.view.bounds.size.height);
            self.animationView.center = CGPointMake(self.animationView.center.x, self.animationView.center.y + self.animationView.bounds.size.height);
        } completion:^(BOOL finished) {
            STRONG_SELF;
            [self dealFiishedDismissViewControllerAnimated:animated];
            if (completion) {
                completion();
            }
        }];
    }else{
        [self dealFiishedDismissViewControllerAnimated:animated];
        if (completion) {
            completion();
        }
    }
}

//是否是pc
- (BOOL)isPc{
    return YES;
}

@end
