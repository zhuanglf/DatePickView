//
//  WKBaseAnimation.h
//  WKAlertController
//
//  Created by penghe on 16/10/8.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKAlertController.h"

@interface WKBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, readonly) BOOL isPresenting; // present . dismiss

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting;

// if you only want alert or actionsheet style ,you can judge that you don't need and return nil
//  code : only support alert style
//  if (preferredStyle == TYAlertControllerStyleAlert) {
//      return [super alertAnimationIsPresenting:isPresenting];
//  }
//  return nil;
+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(WKAlertTransitionAnimationStyle) preferredStyle;


// override transiton time
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

// override present
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

// override dismiss
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
