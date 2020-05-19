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

- (instancetype)initWithTextField:(UITextField*)textField;

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

///最大输入文字数量
@property (nonatomic, assign) NSInteger maxCharacterCount;

///只能输入正正数
@property (nonatomic, assign) BOOL onlyPositiveNumber;

/// 最多只能输入小数 的个数
@property (nonatomic, assign) NSInteger maxFloatCount;

/// 禁止输入空格
@property (nonatomic, assign) BOOL banBlankSpace;

@end

/// 调用 .ax_delegateHandler.对应属性
@interface UITextField (AXAction)

// UITextField  代理对象,直接调用block
// 例子:
// tf.ax_delegateHandler.didBeginBlock = ^(UITextField *textField) {
//
// };
// 最好不要用自己做代理,有bug
@property (nonatomic, strong, readonly) AXTextFieldDelegateHandler* ax_delegateHandler;

/// 编辑配置
@property(nonatomic, strong, readonly) AXKeyboardObserve* ax_keyboardObserve;


@end
