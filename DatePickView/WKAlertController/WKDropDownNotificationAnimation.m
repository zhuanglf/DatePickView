//
//  WKDropDownNotificationAnimation.m
//  WKAlertController
//
//  Created by penghe on 16/10/14.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKDropDownNotificationAnimation.h"

@implementation WKDropDownNotificationAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.45;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WKAlertController *alertController = (WKAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    alertController.backgroundView.alpha = 0.0;

    switch (alertController.preferredStyle) {

        case WKDropDownNotificationAnimationStyle:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(alertController.alertView.frame));

            break;
        default:
            break;
    }

    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];

    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.95 initialSpringVelocity:0.5 options:0 animations:^{
        alertController.backgroundView.alpha = 1.0;

        switch (alertController.preferredStyle) {

            case WKDropDownNotificationAnimationStyle:

                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alertController.alertView.transform = CGAffineTransformIdentity;

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];



}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    WKAlertController *alertController = (WKAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {

            case WKDropDownNotificationAnimationStyle:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(alertController.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
