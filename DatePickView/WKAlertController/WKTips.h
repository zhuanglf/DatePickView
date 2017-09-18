//
//  WKTips.h
//  showprogresstest
//
//  Created by YuZhenKao on 2016/10/11.
//  Copyright © 2016年 YuZhenKao. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface WKTips : UIView

/** 标题 */
@property (copy ,nonatomic) NSString *text;
/** 文字颜色 默认是黑色*/
@property (strong ,nonatomic) UIColor *textColor;
/** 字体 */
@property (nonatomic) UIFont *font;
/** 根据文本自动调整高度 default is YES */
@property (assign,nonatomic) BOOL autoTextHeight;
/** 展示自定义的view */
@property (strong ,nonatomic) UIView *customView;
/** 阴影颜色 */
@property(nullable, nonatomic,strong) UIColor *shadowColor;
/** 文字阴影 */
@property(nonatomic) CGSize shadowOffset;
/** 文字对齐方式 default is NSTextAlignmentCenter */
@property(nonatomic) NSTextAlignment textAlignment;
/** 换行方式 default is NSLineBreakByWordWrapping */
@property(nonatomic) NSLineBreakMode lineBreakMode;
/** 富文本 */
@property(nullable, nonatomic,copy)   NSAttributedString *attributedText NS_AVAILABLE_IOS(6_0); 
/** 背景色 default is clearColor */
@property (strong ,nonatomic) UIColor *backgroundColor;
/** 透明度 default 1.0*/
@property (assign,nonatomic) CGFloat alpha;
/** 高度,当autoTextHeight = NO时起作用，默认20 */
@property (assign,nonatomic) CGFloat height;

/** 是否隐藏状态栏 default is NO */
@property (assign,nonatomic) BOOL hiddenStatusBar;
/** 自动隐藏 default is YES*/
@property (assign,nonatomic) BOOL autoHidden;
/** 自动隐藏时间 default is 0.4s */
@property (assign,nonatomic) NSTimeInterval autoHiddenTime;
/** 展示时间 default is 0.4s */
@property (assign,nonatomic) NSTimeInterval showTime;

@property (copy, nonatomic) void (^showHandler)(UIView *tipsView);

@property (copy, nonatomic) void (^hiddenHandler)(UIView *tipsView);

- (void)showInNavigationController:(UINavigationController*)controller;

- (void)showTipsIn:(UIView *)view;

- (void)showTipsInWindow;

- (void)hiddenTips;

NS_ASSUME_NONNULL_END

@end
