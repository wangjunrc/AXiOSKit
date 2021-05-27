//
//  AXTextFieldObserve.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/16.
//

#import "AXTextFieldObserve.h"
#import "AXMacros_addProperty.h"
#import "UITextField+AXKit.h"
#import "NSObject+AXAssistant.h"

@interface AXTextFieldObserve ()

@property (nonatomic, weak) UITextField* currentTextField;

@end
#pragma mark - implementation AXTextFieldDelegateHandler

@implementation AXTextFieldObserve

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
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    /// 这里放在一起,分开写,容易bug

    /// 禁止输入空格
    if (self.banBlankSpace) {
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
        if (![string isEqualToString:tem]) {
            return NO;
        }
    }
    
    /// 最大文字个数
    if (self.maxTextLength>0) {
        // 大于最大数量
        if ((textField.text.length + string.length) > self.maxTextLength) {
            return NO;
        }
    }
    
    /// 只能输入正正数
    if (self.onlyPositiveNumber && self.maxFloatCount==0) {
        
        BOOL result = [textField ax_getFloatCount:0 range:range string:string];
        /// 这里避免拦截后面的  规则
        if (!result) {
            return NO;
        }
    }
    
    ///最多只能输入小数 的个数
    if (self.maxFloatCount>0 && !self.onlyPositiveNumber) {
        
        BOOL result = [textField ax_getFloatCount:self.maxFloatCount range:range string:string];
        if (!result) {
            return NO;
        }
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
    self.currentTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setMaxFloatCount:(NSUInteger)maxFloatCount
{
    _maxFloatCount = maxFloatCount;
    //设置键盘
    self.currentTextField.keyboardType = UIKeyboardTypeDecimalPad;
}

#pragma mark - function
- (void)textFieldDidChange
{
    if (self.currentTextField.text.length > self.maxTextLength) {
        self.currentTextField.text = [self.currentTextField.text substringWithRange:NSMakeRange(0, self.maxTextLength)];
    }
}

@end
