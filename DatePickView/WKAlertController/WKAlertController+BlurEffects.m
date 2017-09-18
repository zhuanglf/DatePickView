//
//  WKAlertController+BlurEffects.m
//  WKAlertController
//
//  Created by penghe on 16/10/17.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "WKAlertController+BlurEffects.h"
#import "UIImage+ImageEffects.h"

@implementation WKAlertController (BlurEffects)

#pragma mark - public

- (void)setBlurEffectWithView:(UIView *)view
{
    [self setBlurEffectWithView:view style:BlurEffectStyleLight];
}

- (void)setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle
{
    // time consuming task ,so use dispatch_async .很耗时的操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        UIImage * blurImage = [self blurImageWithSnapshotImage:snapshotImage style:blurStyle];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *blurImageView = [[UIImageView alloc]initWithImage:blurImage];
            blurImageView.userInteractionEnabled = YES;
            self.backgroundView = blurImageView;

        });

    });
}

- (void)setBlurEffectWithView:(UIView *)view effectTintColor:(UIColor *)effectTintColor
{
    // time consuming task ,so use dispatch_async .很耗时的操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        UIImage * blurImage = [snapshotImage applyTintEffectWithColor:effectTintColor];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *blurImageView = [[UIImageView alloc]initWithImage:blurImage];
            blurImageView.userInteractionEnabled = YES;

            self.backgroundView = blurImageView;
        });

    });
}

#pragma mark - private

- (UIImage *)blurImageWithSnapshotImage:(UIImage *)snapshotImage style:(BlurEffectStyle)blurStyle
{
    switch (blurStyle) {
        case BlurEffectStyleLight:
            return [snapshotImage applyLightEffect];
        case BlurEffectStyleDarkEffect:
            return [snapshotImage applyDarkEffect];
        case BlurEffectStyleExtraLight:
            return [snapshotImage applyExtraLightEffect];
        default:
            return nil;
    }
}

@end
