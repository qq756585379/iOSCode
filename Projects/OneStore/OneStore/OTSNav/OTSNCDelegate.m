//
//  OTSNCDelegate.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSVC.h"
#import "OTSNCDelegate.h"
#import "UIViewController+OTSAnimation.h"

@implementation OTSNCDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.appearingVC = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.appearingVC = NO;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactivePopTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        if (self.interactivePopTransition) {
            return [toVC pushInteractions];
        }else {
            return [toVC pushAnimations];
        }
    }else if (operation == UINavigationControllerOperationPop){
        if (self.interactivePopTransition) {
            return [fromVC popInteractions];
        }else {
            return [fromVC popAnimations];
        }
    }
    return nil;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.ownerNC.topViewController isKindOfClass:[OTSVC class]]) {
        OTSVC *vc = (id)self.ownerNC.topViewController;
        if (vc.canDragBack) {
            return YES;
        }
    }
    return NO;
}

- (void)handleEdgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGFloat progress = [recognizer translationInView:self.ownerNC.view].x / (self.ownerNC.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.ownerNC popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

@end
