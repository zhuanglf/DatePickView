//
//  WKAlertAnimation.m
//  WKAlertController
//
//  Created by penghe on 16/10/14.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKAlertAnimation.h"


@implementation WKAlertAnimation
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

        case WKAlertAnimationStyle:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformScale(alertController.alertView.transform,0.1,0.1);

            break;
        default:
            break;
    }

    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];

    [UIView animateWithDuration:0.35 animations:^{

        alertController.backgroundView.alpha = 1.0;

        switch (alertController.preferredStyle) {

            case WKAlertAnimationStyle:
                alertController.alertView.transform = CGAffineTransformIdentity;
                alertController.alertView.alpha = 1.0;

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

    [UIView animateWithDuration:0.35 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {

            case WKAlertAnimationStyle:
                alertController.alertView.transform = CGAffineTransformScale(alertController.alertView.transform,0.1,0.1);
                alertController.alertView.alpha = 0.0;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
