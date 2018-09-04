//
//  UITextField+AXNumberKeyboard.h
//  AXNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXNumberKeyboard.h"

@interface UITextField (AXNumberKeyboard)

// 键盘类型
@property (nonatomic, assign) AXNumberKeyboardType ax_keyboardType;

// 每隔多少个数字空一格
@property (nonatomic, assign) NSInteger ax_interval;

// inputAccessoryView显示的文字
@property (nonatomic, copy) NSString *ax_inputAccessoryText;

/**
 小数点后个数 默认 -1
 会更改 delegate 指向
 */
@property (nonatomic, assign) NSInteger floatCount;

@end


