//
//  UITextField+AXAction.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXTextFieldDelegateObj : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *currentTextField;


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
 */
@property (nonatomic, copy) BOOL(^ax_shouldChangeBlock)(UITextField *textField,NSRange range, NSString *aString);


/**
 只能输入数字
 */
- (void)ax_canShouldChangeNumber;


/**
 只能输入小数
 */
- (void)ax_canShouldChangeFloat:(NSInteger )count;



@end


@interface UITextField (AXAction)


/**
 UITextField  代理对象
 最好不要用自己做代理,有bug
 */
@property (nonatomic, strong) AXTextFieldDelegateObj *axDelegateObj;


@end
