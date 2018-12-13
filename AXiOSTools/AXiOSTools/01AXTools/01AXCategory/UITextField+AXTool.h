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
 * - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 方法中调用,控制输入的字符为最多2位小数的数字 包含0
 */
- (BOOL)ax_getTF2FloatRange:(NSRange)range string:(NSString *)string;

/**
 textField 控制输入的字符为整数  或者 小数
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 
 @param count 0 时,就是只能输入0~9数字 . 不可以输入 , >0 时为小数输入,第一位不为问.,开头只能为一个0
 @param range NSRange
 @param string string
 @return BOOL
 */
- (BOOL)ax_getFloatCount:(NSInteger )count range:(NSRange)range string:(NSString *)string;


@end
