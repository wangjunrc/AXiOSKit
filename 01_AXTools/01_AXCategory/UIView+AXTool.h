//
//  UIView+AXTool.h
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXTool)
/**
 * 指定 角 进行圆角
 */
-(void)ax_roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat )cornerRadius;

/**
 * 左右颤动一下
 */
- (void)ax_shakeByLeftAndRight;

/**
 渐变色
 
 @param colorArray UIColor 数组
 */
-(void)ax_gradientColors:(NSArray <UIColor*>*)colorArray;


/**
边框方向

- AXBorderDirectionTop: 顶部
- AXBorderDirectionLeft: 左边
- AXBorderDirectionBottom: 底部
- AXBorderDirectionRight: 右边
*/
typedef NS_ENUM(NSInteger, AXBorderDirectionType) {
    AXBorderDirectionTop = 0,
    AXBorderDirectionLeft,
    AXBorderDirectionBottom,
    AXBorderDirectionRight
};

/**
 为UIView的某个方向添加边框
 
 @param direction 边框方向
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)ax_addBorder:(AXBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width;


@end
