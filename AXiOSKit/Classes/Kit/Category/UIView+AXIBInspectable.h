//
//  UIView+AXIBInspectable.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/5/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 分类方法,在xib中,不能实时显示,但可以正常使用 编译太慢,弃用
 */
//IB_DESIGNABLE
@interface UIView (AXIBInspectable)

///**
// *  设置圆角
// *  UIView masksToBounds 不设置,方便显示子视图
// */
//@property (nonatomic, assign) IBInspectable CGFloat axCornRadius;
//
///**
// *  可视化设置边框宽度 borderWidth
// */
//@property (nonatomic, assign) IBInspectable CGFloat axBordWidth;
//
///**
// *  可视化设置边框颜色 borderColor
// */
//@property (nonatomic, strong) IBInspectable UIColor *axBordColor;
//
//
///**
// 可视化设置边masksToBounds
// */
//@property (nonatomic, assign) IBInspectable BOOL axMasksToBounds;

@end
