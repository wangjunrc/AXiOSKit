//
//  UITextField+AXTool.h
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/16.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (AXTool)
/**
 * -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 方法中调用,控制输入的字符为最多2位小数的数字 包含0
 */
-(BOOL)getTF2FloatRange:(NSRange)range string:(NSString *)string;

@end
