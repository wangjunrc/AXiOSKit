//
//  UITextField+AXAction.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UITextField+AXAction.h"
#import <objc/runtime.h>
#import "AXMacros_runTime.h"
#import "NSObject+AXKVO.h"
#import "NSString+AXTool.h"

@interface UITextField ()<UITextFieldDelegate>

@end

@implementation UITextField (AXAction)


#pragma mark - function
/**
 只能输入数字 整数
 */
- (void)ax_canShouldChangeNumber {
    
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.ax_shouldChangeBlock = ^BOOL(UITextField *textField, NSRange range, NSString *aString) {
        
        return [aString ax_isNumber];
    };
}

/**
 只能输入小数
 */
- (void)ax_canShouldChangeFloat {
    
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    self.ax_shouldChangeBlock = ^BOOL(UITextField *textField, NSRange range, NSString *aString) {
        
        return [aString ax_isNumber];
    };
}

#pragma mark - action
// 编辑中 事件
- (void)textChnageAction:(UITextField *)textField{
    
    if (self.ax_didEditingChangedBlock) {
        self.ax_didEditingChangedBlock(textField);
    }
}


#pragma mark - delegate

// 控制当前输入框是否能被编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

//当输入框开始时触发 ( 获得焦点触发)
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.ax_didBeginBlock){
        self.ax_didBeginBlock(textField);
    }
}

//询问输入框是否可以结束编辑 ( 键盘是否可以收回)
- (BOOL)textFieldShouldEndEditing:( UITextField*)textField {
    return YES;
}

//当前输入框结束编辑时触发 ( 键盘收回之后触发 )
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.ax_didEndBlock){
        self.ax_didEndBlock(textField);
    }
}

//当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.ax_shouldChangeBlock) {
        
        return self.ax_shouldChangeBlock(textField,range,string);
    }
    
    return YES;
}

//控制输入框清除按钮是否有效 (yes, 有 ;no, 没有)
- (BOOL)textFieldShouldClear:( UITextField*)textField {
    return YES;
}

// 控制键盘是否回收

- (BOOL)textFieldShouldReturn:( UITextField*)textField {
    
    return YES;
}

#pragma mark - set and get

// 开始 set and get
- (void)setAx_didBeginBlock:(void (^)(UITextField *))ax_didBeginBlock{
    self.delegate = self;
    ax_runtimePropertyObjSet(ax_didBeginBlock);
}

- (void (^)(UITextField *))ax_didBeginBlock{
    
    return ax_runtimePropertyAssGet(ax_didBeginBlock);
}


// 编辑中 set and get
- (void)setAx_didEditingChangedBlock:(void (^)(UITextField *))ax_didEditingChangedBlock{
    
    [self addTarget:self action:@selector(textChnageAction:) forControlEvents:UIControlEventEditingChanged];
    
    ax_runtimePropertyObjSet(ax_didEditingChangedBlock);
}
- (void (^)(UITextField *))ax_didEditingChangedBlock{
    
    return ax_runtimePropertyObjGet(ax_didEditingChangedBlock);
}


// 结束 set and get
- (void)setAx_didEndBlock:(void (^)(UITextField *))ax_didEndBlock{
    self.delegate = self;
    ax_runtimePropertyObjSet(ax_didEndBlock);
}
- (void (^)(UITextField *))ax_didEndBlock{
    
    return ax_runtimePropertyObjGet(ax_didEndBlock);
}


// 是否能输入当然文字 set and get
- (void)setAx_shouldChangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))ax_shouldChangeBlock{
    self.delegate = self;
    ax_runtimePropertyObjSet(ax_shouldChangeBlock);
}

- (BOOL (^)(UITextField *, NSRange, NSString *))ax_shouldChangeBlock{
    return ax_runtimePropertyObjGet(ax_shouldChangeBlock);
}



@end
