//
//  UITextField+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/16.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (AXTool)
/**
 * -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 方法中调用,控制输入的字符为最多2位小数的数字 包含0
 */
-(BOOL)getTF2FloatRange:(NSRange)range string:(NSString *)string;

/**
 * 按钮事件封装成block
 */

/**
 UITextField 文字变化事件 block

 @param block block description
 */
-(void)ax_addTargetTextChangedBlock:(void(^)(UITextField *textField))block;

@end
