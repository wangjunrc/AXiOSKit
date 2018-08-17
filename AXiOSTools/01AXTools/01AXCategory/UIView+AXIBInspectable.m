//
//  UIView+AXIBInspectable.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/5/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIView+AXIBInspectable.h"
#import "AXMacros_runTime.h"
#import "AXMacros_addProperty.h"

@implementation UIView (AXIBInspectable)

/**
 *  设置圆角
 *  UIView masksToBounds 不设置,方便显示子视图
 *  @param axCornRadius 可视化视图传入的值
 */
- (void)setAxCornRadius:(CGFloat)axCornRadius{
    ax_addAssignPropertySet(axCornRadius);
    self.layer.cornerRadius = axCornRadius;
    
//    if (![self isMemberOfClass:UIView.class]) {
//         self.layer.masksToBounds = axCornRadius;
//    }
//
}

- (CGFloat)axCornRadius{
    
    return [ax_addPropertyGet(axCornRadius)floatValue];
}

/**
 *  设置边框宽度
 *
 *  @param axBordWidth 可视化视图传入的值
 */

- (void)setAxBordWidth:(CGFloat)axBordWidth{
    ax_addAssignPropertySet(axBordWidth);
    if (axBordWidth < 0) return;
    self.layer.borderWidth = axBordWidth;
}

- (CGFloat)axBordWidth{
    return [ax_addPropertyGet(axBordWidth) floatValue];
}

/**
 *  设置边框颜色
 *
 *  @param axBordColor 可视化视图传入的值
 */
- (void)setAxBordColor:(UIColor *)axBordColor{
    ax_addPropertyGet(axBordColor);
    self.layer.borderColor = axBordColor.CGColor;
}

- (UIColor *)axBordColor{
    return ax_addPropertyGet(axBordColor);
}

/**
 可视化设置边masksToBounds
 */
- (void)setAxMasksToBounds:(BOOL)axMasksToBounds{
    ax_addPropertyGet(axMasksToBounds);
    self.layer.masksToBounds = axMasksToBounds;
}

- (BOOL)axMasksToBounds{
    return ax_addPropertyGet(axMasksToBounds);
}

@end
