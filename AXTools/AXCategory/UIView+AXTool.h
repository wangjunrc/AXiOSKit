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

@end
