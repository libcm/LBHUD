//
//  LBHUD.h
//
//
//  Created by lib on 2018/11/16.
//  Copyright © 2018年 lib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBHUD : UIView

/**
 显示HUD
 */
+ (LBHUD *)show;

/**
 隐藏HUD
 */
+ (void)hide;

/**
 显示提示语  默认显示2秒

 @param message 提示语
 */
+ (LBHUD *)showWithMessage:(NSString *)message;

/**
 显示HUD  默认显示2秒

 @param delay 显示时长
 */
+ (LBHUD *)showWithAfterDelay:(NSTimeInterval)delay;

/**
 显示HUD  默认显示2秒

 @param delay 显示时长
 @param complete 隐藏HUD时的回调
 */
+ (LBHUD *)showWithAfterDelay:(NSTimeInterval)delay complete:(void(^)(void))complete;

/**
 设置HUD背景色, 除showWithMessage:都可用

 @param color 背景色
 */
- (void)setBackgroundColor:(UIColor *)color;

/**
 设置HUD颜色, 除showWithMessage:都可用

 @param color HUD颜色
 */
- (void)setTintColor:(UIColor *)color;

/**
 设置提示语属性, 只限showWithMessage可用

 @param attributes 属性
 */
- (void)setMessageAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes;

/**
 设置提示语背景色, 只限showWithMessage可用

 @param color 背景色
 */
- (void)setMessageBackgroundColor:(nullable UIColor *)color;

/**
 设置提示语背景圆角, 只限showWithMessage可用

 @param radius 圆角
 */
- (void)setMessageBackgroundRadius:(CGFloat)radius;

@end
