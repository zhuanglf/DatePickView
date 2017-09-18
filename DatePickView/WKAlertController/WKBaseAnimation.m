//
//  WKBaseAnimation.m
//  WKAlertController
//
//  Created by penghe on 16/10/8.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKBaseAnimation.h"
@interface WKBaseAnimation ()
@property (nonatomic, assign) BOOL isPresenting;
@end
@implementation WKBaseAnimation
- (instancetype)initWithIsPresenting:(BOOL)isPresenting
{
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting
{
    return [[self alloc]initWithIsPresenting:isPresenting];
}

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(WKAlertTransitionAnimationStyle)preferredStyle
{
    return [[self alloc]initWithIsPresenting:isPresenting];
}

// override this moethod
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresenting) {
        [self presentAnimateTransition:transitionContext];
    }else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

}
@end
