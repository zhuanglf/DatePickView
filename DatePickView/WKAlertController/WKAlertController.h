//
//  WKAlertController.h
//  WKAlertController
//
//  Created by penghe on 16/10/8.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKAlertTransitionAnimationStyle) {
    WKSliderFromLeftAnimationStyle = 0,
    WKSliderFromRightAnimationStyle,
    WKDropDownAnimationStyle,
    WKDropDownNotificationAnimationStyle,
    WKActionSheetAnimationStyle,
    WKAlertAnimationStyle
};
@interface WKAlertController : UIViewController


@property (nonatomic, strong) UIColor *backgroundColor; // set backgroundColor
@property (nonatomic, strong) UIView *backgroundView; // you set coustom view to it

@property (nonatomic, assign, readonly) WKAlertTransitionAnimationStyle preferredStyle;

@property (nonatomic, strong, readonly) UIView *alertView;

@property (nonatomic, assign, readonly) Class transitionAnimationClass;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

@property (nonatomic, assign) CGFloat sliderFromLeftConstant;  // default 0
@property (nonatomic, assign) CGFloat sliderFromRightConstant;  // default 0

@property (nonatomic, assign) CGFloat alertViewOriginY;  // default center Y



// alertView lifecycle block
@property (copy, nonatomic) void (^viewWillShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewWillHideHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidHideHandler)(UIView *alertView);

// dismiss controller completed block
@property (nonatomic, copy) void (^dismissComplete)(void);


+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(WKAlertTransitionAnimationStyle)preferredStyle;

- (void)dismissViewControllerAnimated: (BOOL)animated;

@end


// Transition Animate
@interface WKAlertController (TransitionAnimate)<UIViewControllerTransitioningDelegate>

@end