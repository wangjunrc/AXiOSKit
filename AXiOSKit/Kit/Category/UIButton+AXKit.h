//
//  UIButton+AXKit.h
//
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXKitEnum.h"

@interface UIButton (AXKit)

/**
 * 按钮事件封装成block
 */
- (void)ax_addTargetBlock:(void(^_Nullable)(UIButton * _Nullable button))block;

/**
 修改button 图片位置
 
 @param postion 枚举
 @param spacing 间隙
 */
- (void)ax_setImagePosition:(AXButtonImagePosition)postion spacing:(CGFloat)spacing;

/**
 UIControlStateNormal 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateNormal:(nullable NSString *)title;

/**
 UIControlStateDisabled 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateDisabled:(nullable NSString *)title;

/**
 UIControlStateSelected 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateSelected:(nullable NSString *)title;

/**
 UIControlStateHighlighted 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateHighlighted:(nullable NSString *)title;

/**
 UIControlStateNormal 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateNormal:(nullable UIColor *)color;

/**
 UIControlStateHighlighted 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateHighlighted:(nullable UIColor *)color;

/**
 UIControlStateDisabled 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateDisabled:(nullable UIColor *)color;

/**
 UIControlStateSelected 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateSelected:(nullable UIColor *)color;


/**
 ax_setImageStateNormal image
 
 @param image image
 */
- (void)ax_setImageStateNormal:(nullable NSString *)image;
/**
 UIControlStateHighlighted image
 
 @param image image
 */
- (void)ax_setImageColorStateHighlighted:(nullable NSString *)image;

/**
 UIControlStateDisabled image
 
 @param image image
 */
- (void)ax_setImageStateDisabled:(nullable NSString *)image;

/**
 UIControlStateSelected image
 
 @param image image
 */
- (void)ax_setImageColorStateSelected:(nullable NSString *)image;

@end
