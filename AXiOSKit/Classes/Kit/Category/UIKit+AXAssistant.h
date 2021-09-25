//
//  UIKit+AXAssistant.h
//  AXiOSKit
//
//  Created by axing on 2019/1/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**屏宽比*/
UIKIT_EXTERN CGFloat ax_screen_scale(void);

/**屏宽*/
UIKIT_EXTERN CGFloat ax_screen_width(void);

/**屏高*/
UIKIT_EXTERN CGFloat ax_screen_height(void);

/**竖屏宽*/
UIKIT_EXTERN CGFloat ax_screen_width_in_portrait(void);

/**竖屏高*/
UIKIT_EXTERN CGFloat ax_screen_height_in_portrait(void);

/**横屏宽*/
UIKIT_EXTERN CGFloat ax_screen_width_in_landscape(void);

/**横屏高*/
UIKIT_EXTERN CGFloat ax_screen_height_in_landscape(void);

UIKIT_EXTERN CGFloat ax_screen_center_x(void);

UIKIT_EXTERN CGFloat ax_pixel(void);

/// UINavigationController 栏高
UIKIT_EXTERN CGFloat ax_navigation_bar_height(void);

/// UITabBarController 高度
UIKIT_EXTERN CGFloat ax_tab_bar_height(void);

/// 导航栏高+齐刘海及状态栏
UIKIT_EXTERN CGFloat ax_navigation_and_status_height(void);

/// 状态栏及齐刘海  等于 ax_safe_area_insets_top
UIKIT_EXTERN CGFloat ax_status_bar_height(void);

/// 安全区域 UIEdgeInsets 顶部的状态栏及齐刘海(状态栏属于安全区域),底部的指示条
UIKIT_EXTERN UIEdgeInsets ax_safe_area_insets(void);

/// 安全区域 UIEdgeInsets top, 状态栏高度 或者 状态栏及齐刘海
UIKIT_EXTERN CGFloat ax_safe_area_insets_top(void);

/// 安全区域 UIEdgeInsets left
UIKIT_EXTERN CGFloat ax_safe_area_insets_left(void);

/// 安全区域 UIEdgeInsets bottom*
UIKIT_EXTERN CGFloat ax_safe_area_insets_bottom(void);

/// 安全区域 UIEdgeInsets righ
UIKIT_EXTERN CGFloat ax_safe_area_insets_right(void);

/// 安全区域 UIEdgeInsets bottom 偏移 如果 bottom>0 就返回bottom bottom==0 就返回offset
/// 主要用于 底部按钮 约束底部的 指示条距离
UIKIT_EXTERN CGFloat ax_safe_area_insets_bottom_offset(CGFloat offset);

UIKIT_EXTERN CGFloat ax_safe_area_insets_bottom_zero_offset(CGFloat offset);

UIKIT_EXTERN CGFloat ax_screen_adaptive_float(CGFloat floatValue);

UIKIT_EXTERN CGFloat ax_screen_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);

UIKIT_EXTERN CGPoint ax_screen_adaptive_point(CGPoint pointValue);

UIKIT_EXTERN CGSize ax_screen_adaptive_size(CGSize sizeValue);

UIKIT_EXTERN CGRect ax_screen_adaptive_rect(CGRect rectValue);

UIKIT_EXTERN CGFloat ax_screen_vertical_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);

/// 当前活动窗口的控制器
UIKIT_EXTERN UIViewController *ax_currentViewController(void);

/// 设置根控制器
/// @param vc UIViewController
UIKIT_EXTERN void ax_setRootViewController(UIViewController *vc);

/**
 * app代理
 */
UIKIT_EXTERN id <UIApplicationDelegate> ax_mainAppDelegate(void);

/**
 * app根控制器
 */
UIKIT_EXTERN UIViewController *ax_rootViewController(void);

/**
 * AppDelegate app根控制器 个别情况下 AXRootViewController 取值不对
 */
UIKIT_EXTERN UIViewController *ax_rootViewController_appDelegate(void);

/**
 keyWindow
 */
UIKIT_EXTERN UIWindow *ax_keyWindow(void);

/**
 创建xib With xib 名称
 
 @param name xib 名称
 @return UINib
 */
UIKIT_EXTERN UINib *ax_Nib(NSString *name);

/**
 创建xib
 
 @param aClass xib 名称 xib与源文件名称一致
 @return UINib
 */
UIKIT_EXTERN UINib *ax_NibClass(Class _Nonnull aClass);

/**
 UIImage With 图片名
 
 @param name 图片名
 @return UIImage
 */
UIKIT_EXTERN UIImage *ax_Image(NSString *name);

/**键盘背景色透明 alpha=0 */
UIKIT_EXTERN void ax_keyboard_bg_alpha_zero(void);

/**键盘背景色透明*/
UIKIT_EXTERN void ax_keyboard_bg_alpha(CGFloat alpha);

/**键盘背景UIInputSetHostView*/
UIKIT_EXTERN UIView *ax_keyboard_host_view(void);

NS_ASSUME_NONNULL_END
