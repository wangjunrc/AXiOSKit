//
//  UITextField+AXAction.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (AXAction)

/**
 开始编辑
 */
@property (nonatomic, copy) void(^ax_didBeginBlock)(UITextField *textField) ;

/**
 辑中
 */
@property (nonatomic, copy) void(^ax_didEditingChangedBlock)(UITextField *textField);

/**
 结束编辑
 */
@property (nonatomic, copy) void(^ax_didEndBlock)(UITextField *textField);

/**
 是否能输入当前文字
 
 比如:控制指定位数的小数 如下写
 self.tf.ax_shouldChangeBlock = ^BOOL(UITextField *textField, NSRange range, NSString *aString) {
 
 NSString *text = [NSString stringWithFormat:@"%@%@",textField.text,aString];
 return [text ax_isFloat:3];
 //或者
 return [textField ax_getTF2FloatRange:range string:aString];
 */
@property (nonatomic, copy) BOOL(^ax_shouldChangeBlock)(UITextField *textField,NSRange range, NSString *aString);


/**
 只能输入数字
 */
- (void)ax_canShouldChangeNumber;


@end
