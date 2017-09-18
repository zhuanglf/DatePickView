//
//  WKAlertController+BlurEffects.h
//  WKAlertController
//
//  Created by penghe on 16/10/17.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKAlertController.h"

typedef NS_ENUM(NSUInteger, BlurEffectStyle) {
    BlurEffectStyleLight,
    BlurEffectStyleExtraLight,
    BlurEffectStyleDarkEffect,
};

@interface WKAlertController (BlurEffects)

- (void)setBlurEffectWithView:(UIView *)view;

- (void)setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle;

- (void)setBlurEffectWithView:(UIView *)view effectTintColor:(UIColor *)effectTintColor;

@end
