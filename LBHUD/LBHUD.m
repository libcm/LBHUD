//
//  LBHUD.m
//  
//
//  Created by lib on 2018/11/16.
//  Copyright © 2018年 lib. All rights reserved.
//

#import "LBHUD.h"

#define HUD_WEEK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;    // 弱引用
#define HUD_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width    // 屏幕宽度
#define HUD_BACKGROUNDVIEW_HEIGHT 100.f // 背景宽高
#define HUD_MESSAGE_BACKGROUND_MARGIN 20.f  // 提示语背景间距
#define HUD_CORNERRADIUS 10.f   // 圆角
#define HUD_FONT 13.f   // 提示语默认字体大小
#define HUD_DELAY 2 // 默认时长
#define HUD_MESSAGE_BACKGROUNDVIEW_WIDTH (HUD_SCREEN_WIDTH - 2 * HUD_MESSAGE_BACKGROUND_MARGIN) // 提示语背景宽度
#define HUD_MESSAGE_BACKGROUND_COLOR [UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(244/255.0) alpha:0.99]   // 提示语背景色
#define HUD_MAIN_COLOR [[UIColor blackColor] colorWithAlphaComponent:0.25]  // HUD背景色
#define HUD_BACKGROUND_COLOR [[UIColor blackColor] colorWithAlphaComponent:0.45f]   // 菊花背景色
#define HUD_MESSAGE_COLOR [UIColor blackColor]  // 提示语颜色

@interface LBHUD()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *messageBcakgroundView;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation LBHUD
#pragma mark -- Public method --
+ (LBHUD *)show {
    LBHUD *hud = [[LBHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIActivityIndicatorView *indicatorView = [hud activityIndicatorView];
    indicatorView.center = hud.center;
    [indicatorView startAnimating];
    UIView *backgroundView = [hud backgroundView];
    backgroundView.center = hud.center;
    [hud addSubview:backgroundView];
    [hud addSubview:indicatorView];
    [hud addToWindow];
    return hud;
}

+ (void)hide {
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[LBHUD class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

+ (LBHUD *)showWithMessage:(NSString *)message {
    LBHUD *hud = [[LBHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UILabel *messageLabel = [hud messageLabel];
    messageLabel.text = message;
    UIView *backgroundView = [hud messageBcakgroundView];
    [hud addSubview:backgroundView];
    [hud addSubview:messageLabel];
    [hud setMessageFrame];
    [hud addToWindow];
    HUD_WEEK_SELF(ws);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUD_DELAY * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws hide];
    });
    return hud;
}

+ (LBHUD *)showWithAfterDelay:(NSTimeInterval)delay {
    LBHUD *hud = [self show];
    HUD_WEEK_SELF(ws);
    NSTimeInterval time = delay <= 0 ? HUD_DELAY : delay;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws hide];
    });
    return hud;
}

+ (LBHUD *)showWithAfterDelay:(NSTimeInterval)delay complete:(void(^)(void))complete {
    LBHUD *hud = [self show];
    HUD_WEEK_SELF(ws);
    NSTimeInterval time = delay <= 0 ? HUD_DELAY : delay;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws hide];
        complete();
    });
    return hud;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.backgroundView.backgroundColor = color;
}

- (void)setTintColor:(UIColor *)color {
    self.activityIndicatorView.color = color;
}

- (void)setMessageAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes {
    if (!attributes) {return;}
    UIColor *color = attributes[NSForegroundColorAttributeName];
    UIFont *font = attributes[NSFontAttributeName];
    if (color) {
        self.messageLabel.textColor = color;
    }
    if (font) {
        self.messageLabel.font = font;
        [self setMessageFrame];
    }
}

- (void)setMessageBackgroundColor:(UIColor *)color {
    self.messageBcakgroundView.backgroundColor = color;
}

- (void)setMessageBackgroundRadius:(CGFloat)radius {
    self.messageBcakgroundView.layer.cornerRadius = radius;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.backgroundColor = HUD_MAIN_COLOR;
    }
    return self;
}

#pragma mark -- Private method --
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityIndicatorView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUD_BACKGROUNDVIEW_HEIGHT, HUD_BACKGROUNDVIEW_HEIGHT)];
        _backgroundView.backgroundColor = HUD_BACKGROUND_COLOR;
        _backgroundView.layer.cornerRadius = HUD_CORNERRADIUS;
        _backgroundView.layer.masksToBounds = YES;
    }
    return _backgroundView;
}

- (UIView *)messageBcakgroundView {
    if (!_messageBcakgroundView) {
        _messageBcakgroundView = [[UIView alloc] init];
        _messageBcakgroundView.backgroundColor = HUD_MESSAGE_BACKGROUND_COLOR;
        _messageBcakgroundView.layer.cornerRadius = HUD_CORNERRADIUS;
        _messageBcakgroundView.layer.masksToBounds = YES;
    }
    return _messageBcakgroundView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = HUD_MESSAGE_COLOR;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:HUD_FONT];
    }
    return _messageLabel;
}

- (void)setMessageFrame {
    CGFloat height = [self.messageLabel sizeThatFits:CGSizeMake(HUD_MESSAGE_BACKGROUNDVIEW_WIDTH - 2 * HUD_MESSAGE_BACKGROUND_MARGIN, CGFLOAT_MAX)].height;
    self.messageLabel.frame = CGRectMake(0, 0, HUD_MESSAGE_BACKGROUNDVIEW_WIDTH - 2 * HUD_MESSAGE_BACKGROUND_MARGIN, height);
    self.messageBcakgroundView.frame = CGRectMake(0, 0, HUD_MESSAGE_BACKGROUNDVIEW_WIDTH, height + 2 * HUD_MESSAGE_BACKGROUND_MARGIN);
    self.messageBcakgroundView.center = self.center;
    self.messageLabel.center = self.center;
}

- (void)addToWindow {
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
}

@end
