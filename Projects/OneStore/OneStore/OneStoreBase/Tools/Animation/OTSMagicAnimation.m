//
//  OTSMagicAnimation.m
//  OneStoreFramework
//
//  Created by Aimy on 4/9/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSMagicAnimation.h"

@implementation OTSMagicAnimation

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    
    NSArray *fromViews = fromViewController.animationViews;
    NSArray *toViews = toViewController.animationViews;
    
    NSAssert([fromViews count] == [toViews count], @"*** The count of fromviews and toviews must be the same! ***");
    
    NSMutableArray *fromViewSnapshotArray = [[NSMutableArray alloc] init];
    for (UIView *fromView in fromViews) {
        UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
        fromViewSnapshot.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
        fromView.hidden = YES;
        [fromViewSnapshotArray addObject:fromViewSnapshot];
    }
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    
    for (UIView *toView in toViews) {
        toView.hidden = YES;
    }
    
    for (NSUInteger i = [fromViewSnapshotArray count]; i > 0; i--) {
        [containerView addSubview:[fromViewSnapshotArray objectAtIndex:i - 1]];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toViewController.view.alpha = 1.0;
        for (NSUInteger i = 0; i < [fromViews count]; i++) {
            UIView *toView = [toViews objectAtIndex:i];
            UIView *fromViewSnapshot = [fromViewSnapshotArray objectAtIndex:i];
            CGRect frame = [containerView convertRect:toView.frame fromView:toView.superview];
            fromViewSnapshot.frame = frame;
        }
    } completion:^(BOOL finished) {
        for (NSUInteger i = 0; i < [fromViews count]; i++) {
            UIView *toView = [toViews objectAtIndex:i];
            UIView *fromView = [fromViews objectAtIndex:i];
            UIView *fromViewSnapshot = [fromViewSnapshotArray objectAtIndex:i];
            toView.hidden = NO;
            fromView.hidden = NO;
            [fromViewSnapshot removeFromSuperview];
        }
        
        [transitionContext completeTransition: ! [transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation UIViewController (OTSMagicAnimation)

- (NSArray *)animationViews
{
    return @[];
}

@end
