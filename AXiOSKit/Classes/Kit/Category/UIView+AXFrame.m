//
//  UIScrollView+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 2016/12/2.
//  Copyright © 2016年 liuweixing All rights reserved.
//


//重写每个属性的set和get方法
#import "UIView+AXFrame.h"

@implementation UIView (AXFrame)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}


- (void)removeAllSubviews{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


/*========================ax 前缀==================================*/

- (void)setAx_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)ax_x{
    return self.frame.origin.x;
}

- (void)setAx_y:(CGFloat)ax_y{
    CGRect frame = self.frame;
    frame.origin.y = ax_y;
    self.frame = frame;
}

- (CGFloat)ax_y{
    return self.frame.origin.y;
}
- (void)setAx_centerX:(CGFloat)ax_centerX{
    CGPoint center = self.center;
    center.x = ax_centerX;
    self.center = center;
}

- (CGFloat)ax_centerX{
    return self.center.x;
}

- (void)setAx_centerY:(CGFloat)ax_centerY{
    CGPoint center = self.center;
    center.y = ax_centerY;
    self.center = center;
}

- (CGFloat)ax_centerY{
    return self.center.y;
}

- (void)setAx_width:(CGFloat)ax_width {
    CGRect frame = self.frame;
    frame.size.width = ax_width;
    self.frame = frame;
}

- (CGFloat)ax_width{
    return self.frame.size.width;
}

- (void)setAx_height:(CGFloat)ax_height {
    CGRect frame = self.frame;
    frame.size.height = ax_height;
    self.frame = frame;
}

- (CGFloat)ax_height{
    return self.frame.size.height;
}


- (void)setAx_size:(CGSize)ax_size {
    CGRect frame = self.frame;
    frame.size = ax_size;
    self.frame = frame;
}

- (CGSize)ax_size{
    return self.frame.size;
}

- (void)setAx_origin:(CGPoint)ax_origin {
    CGRect frame = self.frame;
    frame.origin = ax_origin;
    self.frame = frame;
}

- (CGPoint)ax_origin{
    return self.frame.origin;
}

- (void)setAx_right:(CGFloat)ax_right {
    CGRect frame = self.frame;
    frame.origin.x = ax_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ax_right{
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setAx_left:(CGFloat)ax_left {
    CGRect frame = self.frame;
    frame.origin.x = ax_left;
    self.frame = frame;
}

- (CGFloat)ax_left{
    
    return self.frame.origin.x;
}

- (void)setAx_top:(CGFloat)ax_top {
    CGRect frame = self.frame;
    frame.origin.y = ax_top;
    self.frame = frame;
}

- (CGFloat)ax_top{
    return self.frame.origin.y;
}

- (void)setAx_bottom:(CGFloat)ax_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ax_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ax_bottom{
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)ax_removeAllSubviews{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}
@end
