//
//  WKSliderFromLeftAnimation.m
//  WKAlertController
//
//  Created by penghe on 16/10/8.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKSliderFromLeftAnimation.h"

@implementation WKSliderFromLeftAnimation
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

        case WKSliderFromLeftAnimationStyle:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(alertController.alertView.frame), 0);

            break;
        default:
            break;
    }

    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];

    [UIView animateWithDuration:0.25 animations:^{
        switch (alertController.preferredStyle) {

            case WKSliderFromLeftAnimationStyle:
                alertController.backgroundView.alpha = 1.0;

                alertController.alertView.transform = CGAffineTransformMakeTranslation(-alertController.sliderFromLeftConstant, 0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
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

            case WKSliderFromLeftAnimationStyle:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(alertController.alertView.frame), 0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
