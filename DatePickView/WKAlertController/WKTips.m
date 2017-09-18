//
//  WKTips.m
//  showprogresstest
//
//  Created by YuZhenKao on 2016/10/11.
//  Copyright © 2016年 YuZhenKao. All rights reserved.
//

#import "WKTips.h"

#define DefaultFrame CGRectMake(0, -CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))

@interface WKTips()

@property (strong ,nonatomic) UIView *finalView;

@property (strong ,nonatomic) UILabel *tipsView;

@property (strong ,nonatomic) UIWindow *overlayWindow;

@property (strong ,nonatomic) UIView *fatherView;

@property (strong ,nonatomic) UINavigationController *navController;

@end

@implementation WKTips
@synthesize overlayWindow;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comminit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self comminit];
    }
    return self;
}

- (void)comminit {
    self.layer.masksToBounds = YES;
    self.tipsView.textColor = [UIColor blackColor];
    self.tipsView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.autoTextHeight = YES;
    self.autoHidden = YES;
    self.showTime = 0.4;
    self.autoHiddenTime = 0.4;
    self.height = 20.f;
}

#pragma mark - Properties Getter And Setter

-(void)setText:(NSString *)text {
    self.tipsView.text = text;
}
-(void)setTextColor:(UIColor *)textColor {
    self.tipsView.textColor = textColor;
}
-(void)setFont:(UIFont *)font {
    self.tipsView.font = font;
}
-(void)setShadowColor:(UIColor *)shadowColor {
    self.tipsView.shadowColor = shadowColor;
}
-(void)setShadowOffset:(CGSize)shadowOffset {
    self.tipsView.shadowOffset = shadowOffset;
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment {
    self.tipsView.textAlignment = textAlignment;
}
-(void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    self.tipsView.lineBreakMode = lineBreakMode;
}
-(void)setAttributedText:(NSAttributedString *)attributedText {
    self.tipsView.attributedText = attributedText;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor {
    self.tipsView.backgroundColor = backgroundColor;
}
-(void)setAlpha:(CGFloat)alpha {
    self.tipsView.alpha = alpha;
}
-(UILabel *)tipsView {
    if (_tipsView == nil) {
        _tipsView = [[UILabel alloc]init];
        _tipsView.textAlignment = NSTextAlignmentCenter;
        _tipsView.backgroundColor = [UIColor redColor];
        _tipsView.numberOfLines = 0;
        [self addSubview:_tipsView];
    }
    return _tipsView;
}

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
        overlayWindow.windowLevel = UIWindowLevelStatusBar;
        
        // Transform depending on interafce orientation
        CGAffineTransform rotationTransform = CGAffineTransformMakeRotation([self rotation]);
        self.overlayWindow.transform = rotationTransform;
        self.overlayWindow.frame = CGRectMake(0.f, 0.f, [self rotatedSize].width, [self rotatedSize].height);
        
        // Register for orientation changes
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleRoration:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return overlayWindow;
}
#pragma mark - Actions
- (void)showInNavigationController:(UINavigationController *)controller {
    
    CGRect frame = CGRectMake(0,CGRectGetMaxY(controller.navigationBar.frame) , CGRectGetWidth(controller.navigationBar.frame), self.height);
    self.navController = controller;
    [self showIn:controller.view WithFrame:frame];
}

- (void)showTipsInWindow {
    
    [self showIn:[UIApplication sharedApplication].keyWindow WithFrame:[UIApplication sharedApplication].keyWindow.bounds];
}

- (void)showTipsIn:(UIView *)view {
    [self showIn:view WithFrame:view.frame];

}

- (void)hiddenTips {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if (_hiddenHandler) {
        _hiddenHandler(self.finalView);
    }
    [UIView animateWithDuration:self.autoHiddenTime animations:^{
        self.finalView.alpha = 0;
        self.finalView.frame = DefaultFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.finalView = nil;
        [overlayWindow removeFromSuperview];
        overlayWindow = nil;
    }];
}

- (void)showIn:(UIView *)view WithFrame:(CGRect)frame {
    
    [self.overlayWindow setHidden:NO];
    self.fatherView = view;
    if (self.customView) {
        frame.size.height = self.customView.frame.size.height;
        self.frame = frame;
        self.finalView = self.customView;
    }else {
        
        if (self.autoTextHeight) {
            CGRect new = [self getRectByLabel:self.tipsView AndWidth:frame.size.width];
            frame.size.height = new.size.height;
            self.frame = frame;
        }else {
            self.frame = CGRectMake(0, frame.origin.y, CGRectGetWidth(view.frame), self.height);
        }
        self.finalView = self.tipsView;
        
    }
    self.finalView.frame = DefaultFrame;
    
    [self addSubview:self.finalView];
    
    if ([view isKindOfClass:[UIWindow class]]) {
        [overlayWindow addSubview:self];
    }else {
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }

    
    
    self.hiddenStatusBar? [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade]:0;
    
    if (_showHandler) {
        _showHandler(self.finalView);
    }
    
    [UIView animateWithDuration:self.showTime animations:^{
        self.finalView.frame = self.bounds;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.autoHidden?[self hiddenTips]:0;
        });
    }];
    
}

- (CGRect)getRectByLabel:(UILabel *)sender AndWidth:(CGFloat)width{
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : sender.font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [sender.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:opts
                                         attributes:attributes
                                            context:nil];
    return rect;
}

#pragma mark - Handle Rotation

- (CGFloat)rotation
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat rotation = 0.f;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft: { rotation = -M_PI_2; } break;
        case UIInterfaceOrientationLandscapeRight: { rotation = M_PI_2; } break;
        case UIInterfaceOrientationPortraitUpsideDown: { rotation = M_PI; } break;
        case UIInterfaceOrientationPortrait: { } break;
        default: break;
    }
    return rotation;
}

- (CGSize)rotatedSize
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize rotatedSize = screenSize;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft: { rotatedSize = CGSizeMake(screenSize.height, screenSize.width); } break;
        case UIInterfaceOrientationLandscapeRight: { rotatedSize = CGSizeMake(screenSize.height, screenSize.width); } break;
        case UIInterfaceOrientationPortraitUpsideDown: { } break;
        case UIInterfaceOrientationPortrait: { } break;
        default: break;
    }
    return rotatedSize;
}

- (void)handleRoration:(id)sender
{
    
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation([self rotation]);
    self.overlayWindow.transform = rotationTransform;
                         // Transform invalidates the frame, so use bounds/center
    self.overlayWindow.frame = CGRectMake(0.f, 0.f, [self rotatedSize].width, [self rotatedSize].height);
    
    CGFloat originY ;
    if ([self.fatherView isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        originY = CGRectGetMaxY(self.navController.navigationBar.frame);
        
    }else {
        originY = self.frame.origin.y;

    }
    
    self.frame = CGRectMake(self.frame.origin.x, originY, self.fatherView.frame.size.width, self.frame.size.width);
    self.finalView.frame = CGRectMake(self.finalView.frame.origin.x,self.finalView.frame.origin.y, self.frame.size.width, self.finalView.frame.size.height);
                    
}
@end
