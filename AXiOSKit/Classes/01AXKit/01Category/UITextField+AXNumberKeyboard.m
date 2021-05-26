//
//  UITextField+AXNumberKeyboard.m
//  AXNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "UITextField+AXNumberKeyboard.h"
#import <objc/runtime.h>

#import "AXMacros_addProperty.h"
#import "UITextField+AXKit.h"
#import "NSString+AXKit.h"
#import "UIKit+AXAssistant.h"

@implementation UITextField (AXNumberKeyboard)

#pragma mark -  set and get

- (void)setAx_keyboardType:(AXNumberKeyboardType)ax_keyboardType{
    
    AXNumberKeyboard *inputView = [[AXNumberKeyboard alloc] initWithInputType:ax_keyboardType];
    inputView.textInput = self;
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(ax_keyboardType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AXNumberKeyboardType)ax_keyboardType{
    return [objc_getAssociatedObject(self, @selector(setAx_keyboardType:)) integerValue];
}


- (void)setAx_interval:(NSInteger)ax_interval{
    if([self.inputView isKindOfClass:[AXNumberKeyboard class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(ax_interval)];
    objc_setAssociatedObject(self, _cmd, @(ax_interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)ax_interval{
    return [objc_getAssociatedObject(self, @selector(setAx_interval:)) integerValue];
}


- (void)setAx_inputAccessoryText:(NSString *)ax_inputAccessoryText{
    // inputAccessoryView
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ax_screen_width(), 35)];
    // 顶部分割线
    UIView *tLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ax_screen_width(), 0.5)];
    tLine.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    // 字体label
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ax_screen_width(), 35)];
    tLabel.text = ax_inputAccessoryText;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont systemFontOfSize:14.0];
    tLabel.backgroundColor = [UIColor whiteColor];
    
    [tView addSubview:tLabel];
    [tView addSubview:tLine];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, ax_inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)ax_inputAccessoryText{
    return objc_getAssociatedObject(self, @selector(ax_inputAccessoryText));
}


- (void)setFloatCount:(NSInteger)floatCount{
    ax_setAssignPropertyAssociated(floatCount);
}

- (NSInteger)floatCount{
    return [ax_getValueAssociated(floatCount) integerValue];
}



@end
