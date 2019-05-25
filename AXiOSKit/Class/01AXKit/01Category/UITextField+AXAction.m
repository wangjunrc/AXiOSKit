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


#pragma mark - implementation AXTextFieldDelegateHandler

@implementation AXTextFieldDelegateHandler


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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.didBeginBlock){
        self.didBeginBlock(textField);
    }
}

/**
 * 当前输入框结束编辑时触发 ( 键盘收回之后触发 )
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.didEndBlock){
        self.didEndBlock(textField);
    }
}

/**
 当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (self.shouldChangeBlock) {
        return self.shouldChangeBlock(textField,range,string);
    }
    
    return YES;
}

- (void)setDidEditingChangedBlock:(void (^)(UITextField *))didEditingChangedBlock{
    _didEditingChangedBlock = didEditingChangedBlock;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TextFieldChangedAction:) name:UITextFieldTextDidChangeNotification object:self.currentTextField];
}

- (void)TextFieldChangedAction:(NSNotification *)note{
    
    UITextField *tf = ( UITextField *)note.object;
    
    if( self.didEditingChangedBlock ){
        
        self.didEditingChangedBlock(tf);
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


#pragma mark function


/**
 只能输入数字 整数
 */
- (void)canShouldChangeNumber {
    self.currentTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.shouldChangeBlock = ^BOOL(UITextField *textField, NSRange range, NSString *aString) {
        return [textField ax_getFloatCount:0 range:range string:aString];;
    };
    
}

/**
 只能输入小数
 */
- (void)canShouldChangeFloat:(NSInteger )count {
    
    self.currentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.shouldChangeBlock = ^BOOL(UITextField *textField, NSRange range, NSString *aString) {
        
        return [textField ax_getFloatCount:count range:range string:aString];
        
    };
}


@end


#pragma mark - implementation UITextField



@implementation UITextField (AXAction)


- (void)setAxDelegateHandler:(AXTextFieldDelegateHandler *)axDelegateHandler {
     ax_setStrongPropertyAssociated(axDelegateHandler);
}

- (AXTextFieldDelegateHandler *)axDelegateHandler{
    
    AXTextFieldDelegateHandler *handler = ax_getValueAssociated(axDelegateHandler);
    
    if (handler == nil ){
        
        handler = [[AXTextFieldDelegateHandler alloc]init];
        handler.currentTextField = self;
        self.delegate = handler;
        self.axDelegateHandler = handler;
    }
    return handler;
}



@end
