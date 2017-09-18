//
//  WKAlertController+TransitionAnimate.m
//  WKAlertController
//
//  Created by penghe on 16/10/8.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKAlertController.h"
#import "WKSliderFromLeftAnimation.h"
#import "WKSliderFromRightAnimation.h"
#import "WKActionSheetAnimation.h"
#import "WKDropDownNotificationAnimation.h"
#import "WKAlertAnimation.h"

@implementation WKAlertController (TransitionAnimate)
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.preferredStyle) {
        case WKSliderFromLeftAnimationStyle:
            return [WKSliderFromLeftAnimation alertAnimationIsPresenting:YES];
        case WKSliderFromRightAnimationStyle:
            return [WKSliderFromRightAnimation alertAnimationIsPresenting:YES];
        case WKActionSheetAnimationStyle:
            return [WKActionSheetAnimation alertAnimationIsPresenting:YES];
        case WKDropDownNotificationAnimationStyle:
            return [WKDropDownNotificationAnimation alertAnimationIsPresenting:YES];
        case WKAlertAnimationStyle:
            return [WKAlertAnimation alertAnimationIsPresenting:YES];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.preferredStyle) {
        case WKSliderFromLeftAnimationStyle:
            return [WKSliderFromLeftAnimation alertAnimationIsPresenting:NO];
        case WKSliderFromRightAnimationStyle:
            return [WKSliderFromRightAnimation alertAnimationIsPresenting:NO];
        case WKActionSheetAnimationStyle:
            return [WKActionSheetAnimation alertAnimationIsPresenting:NO];
        case WKDropDownNotificationAnimationStyle:
            return [WKDropDownNotificationAnimation alertAnimationIsPresenting:NO];
        case WKAlertAnimationStyle:
            return [WKAlertAnimation alertAnimationIsPresenting:NO];
        default:
            return nil;
    }
}

@end
