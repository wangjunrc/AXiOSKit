//
//  UIButton+AXTool.h
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIButton (AXTool)
/**
 * 按钮事件封装成block
 */
-(void)ax_addTargetBlock:(void(^)(UIButton *button))block;
- (void)ax_buttonWithTime:(CGFloat)countDownTime;
/**
 * 循环时间 事件,初始化时调用,不需要主动调用
 */
- (void)ax_buttonEventsWithTime:(CGFloat)countDownTime block:(void(^)(UIButton *button))block;

@end
