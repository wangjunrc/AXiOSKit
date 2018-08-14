//
//  AXNumberKeyboard.h
//  AXNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度

typedef NS_ENUM(NSUInteger, AXNumberKeyboardType) {
    AXNumberKeyboardTypeInteger,    // 整数键盘
    AXNumberKeyboardTypeFloat,      // 浮点数键盘
    AXNumberKeyboardTypeIDCard,     // 身份证键盘
};

@interface AXNumberKeyboard : UIView

@property (nonatomic, weak) UITextField *textInput;

// 键盘类型
@property (nonatomic, assign) AXNumberKeyboardType inputType;
// 每隔多少个数字空一格
@property (nonatomic, strong) NSNumber *interval;


- (instancetype)initWithInputType:(AXNumberKeyboardType)inputType;


@end
