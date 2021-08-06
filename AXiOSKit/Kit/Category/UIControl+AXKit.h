//
//  UIControl+AXKit.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/5.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AXKit)

/**
 * UIControl addTarget 封装成block
 */
- (void)ax_addTargetEvents:(UIControlEvents)controlEvents block:(void(^_Nullable)(UIControl * _Nullable aControl))block;

/// 的点击响应区域，可用负值扩大点击范围，(-12, -12, -12, -12)。
@property(nonatomic, assign) UIEdgeInsets ax_hitTestEdgeInsets;


/// 按钮响应外边距，负值为扩大，正值为缩小。 完全支持自动布局，只需要将方法写在自动布局方法下面即可
/// 四周相同增加 UIEdgeInsetsMake(-20, -20, -20, -20);
/**
 x = x+left;
 y = y+top;
 w = w -left -right;
 h = h - top -bottom;
 */
@property (nonatomic, assign) UIEdgeInsets ax_hitPointEdgeInsets;


@end
