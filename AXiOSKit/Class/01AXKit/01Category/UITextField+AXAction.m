//
//  UITextField+AXAction.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UITextField+AXAction.h"
#import "AXMacros_addProperty.h"
#import "UITextField+AXKit.h"
#import "AXExternFunction.h"

@interface AXTextFieldDelegateHandler ()

@property (nonatomic, weak) UITextField* currentTextField;

@end
#pragma mark - implementation AXTextFieldDelegateHandler

@implementation AXTextFieldDelegateHandler

- (instancetype)initWithTextField:(UITextField*)textField {
    if (self = [self init]) {
        self.currentTextField = textField;
        textField.delegate = self;
    }
    return self;
}
#pragma mark delegate

// 控制当前输入框是否能被编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//    return YES;
//}
//
////询问输入框是否可以结束编辑 ( 键盘是否可以收回)
//- (BOOL)textFieldShouldEndEditing:( UITextField*)textField {
//    return YES;
//}
//
////控制输入框清除按钮是否有效 (yes, 有 ;no, 没有)
//- (BOOL)textFieldShouldClear:( UITextField*)textField {
//    return YES;
//}
//
//// 控制键盘是否回收
//
//- (BOOL)textFieldShouldReturn:( UITextField*)textField {
//
//    return YES;
//}

/**
 * 当输入框开始时触发 ( 获得焦点触发)
 */
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    if (self.didBeginBlock) {
        self.didBeginBlock(textField);
    }
}

/**
 * 当前输入框结束编辑时触发 ( 键盘收回之后触发 )
 */
- (void)textFieldDidEndEditing:(UITextField*)textField
{
    if (self.didEndBlock) {
        self.didEndBlock(textField);
    }
}

/**
 当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )
 */
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if (self.shouldChangeBlock) {
        return self.shouldChangeBlock(textField, range, string);
    }
    return YES;
}

- (void)setDidEditingChangedBlock:(void (^)(UITextField*))didEditingChangedBlock
{
    _didEditingChangedBlock = didEditingChangedBlock;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldChangedAction:) name:UITextFieldTextDidChangeNotification object:self.currentTextField];
}

- (void)TextFieldChangedAction:(NSNotification*)note
{

    UITextField* tf = (UITextField*)note.object;
    if (self.didEditingChangedBlock) {
        self.didEditingChangedBlock(tf);
    }
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - set
/**
 只能输入正整数
 */
- (void)setOnlyPositiveNumber:(BOOL)onlyPositiveNumber
{
    _onlyPositiveNumber = onlyPositiveNumber;

    if (onlyPositiveNumber) {
        self.currentTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.shouldChangeBlock = ^BOOL(UITextField* textField, NSRange range, NSString* aString) {
            return [textField ax_getFloatCount:0 range:range string:aString];
        };
    } else {
        if (self.shouldChangeBlock) {
            self.shouldChangeBlock = nil;
        }
    }
}

- (void)setMaxFloatCount:(NSUInteger)maxFloatCount
{
    _maxFloatCount = maxFloatCount;

    self.currentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.shouldChangeBlock = ^BOOL(UITextField* textField, NSRange range, NSString* aString) {
        return [textField ax_getFloatCount:maxFloatCount range:range string:aString];
    };
}

- (void)setMaxCharacterCount:(NSUInteger)maxCharacterCount
{
    _maxCharacterCount = maxCharacterCount;

    // 通知方法 截取
    //     [self.currentTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];

    // 代理方法 拦截
    self.shouldChangeBlock = ^BOOL(UITextField* textField, NSRange range, NSString* aString) {
        return [textField ax_maxCharacterCount:maxCharacterCount replacementText:aString];
    };
}

#pragma mark - function
- (void)textFieldDidChange
{
    if (self.currentTextField.text.length > self.maxCharacterCount) {
        self.currentTextField.text = [self.currentTextField.text substringWithRange:NSMakeRange(0, self.maxCharacterCount)];
    }
}

@end

#pragma mark - implementation UITextField

@implementation UITextField (AXAction)

#pragma mark - ax_delegateHandler

- (void)setAx_delegateHandler:(AXTextFieldDelegateHandler*)ax_delegateHandler
{
    ax_setStrongPropertyAssociated(ax_delegateHandler);
}

- (AXTextFieldDelegateHandler*)ax_delegateHandler
{
    AXTextFieldDelegateHandler* handler = ax_getValueAssociated(ax_delegateHandler);
    if (!handler) {
        handler = [[AXTextFieldDelegateHandler alloc] initWithTextField:self];
        handler.currentTextField = self;
//        self.delegate = handler;
        self.ax_delegateHandler = handler;
    }
    return handler;
}

#pragma mark - AXKeyboardObserve
- (void)setAx_keyboardObserve:(AXKeyboardObserve*)ax_keyboardObserve
{
    ax_setStrongPropertyAssociated(ax_keyboardObserve);
}

- (AXKeyboardObserve*)ax_keyboardObserve
{
    AXKeyboardObserve *obj = ax_getValueAssociated(ax_delegateHandler);
    if (obj == nil ){
        obj = [[AXKeyboardObserve alloc] initWithOwner:self];
        self.ax_keyboardObserve = obj;
    }
    return obj;
    
}

@end
