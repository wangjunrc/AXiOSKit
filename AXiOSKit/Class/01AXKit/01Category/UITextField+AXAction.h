//
//  UITextField+AXAction.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXKeyboardObserve.h"

@interface AXTextFieldDelegateHandler : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) UITextField* currentTextField;

/**
 开始编辑
 */
@property (nonatomic, copy) void (^didBeginBlock)(UITextField* textField);

/**
 辑中
 */
@property (nonatomic, copy) void (^didEditingChangedBlock)(UITextField* textField);

/**
 结束编辑
 */
@property (nonatomic, copy) void (^didEndBlock)(UITextField* textField);

/**
 是否能输入当前文字
 */
@property (nonatomic, copy) BOOL (^shouldChangeBlock)(UITextField* textField, NSRange range, NSString* aString);

/**
 只能输入数字
 */
- (void)canShouldChangeNumber;

/**
 只能输入小数
 */
- (void)canShouldChangeFloat:(NSInteger)count;

@end

@interface UITextField (AXAction)

/**
 UITextField  代理对象,直接调用block
 例子:
 tf.ax_delegateHandler.didBeginBlock = ^(UITextField *textField) {
 
 };
 最好不要用自己做代理,有bug
 */
@property (nonatomic, strong, readonly) AXTextFieldDelegateHandler* ax_delegateHandler;

/**
 编辑配置
 */
@property(nonatomic, strong, readonly) AXKeyboardObserve *ax_keyboardObserve;


@end
