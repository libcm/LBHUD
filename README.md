# LBHUD
HUD指示器

[![Version](https://img.shields.io/cocoapods/v/LBHUD.svg?style=flat)](http://cocoapods.org/pods/LBHUD)
[![License](https://img.shields.io/cocoapods/l/LBHUD.svg?style=flat)](https://github.com/libcm/LBHUD/blob/master/LICENSE)
![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)

提供以下方法:

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

使用:
	
	pod 'LBHUD'