//
//  UITextField+AXAction.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXKeyboardObserve.h"
#import "AXTextFieldDelegateObserve.h"

/// 调用 .ax_delegateHandler.对应属性
@interface UITextField (AXAction)

// UITextField  代理对象,直接调用block
// 例子:
// tf.ax_delegateHandler.didBeginBlock = ^(UITextField *textField) {
//
// };
// 最好不要用自己做代理,有bug
@property (nonatomic, strong, readonly) AXTextFieldDelegateObserve* ax_delegateObserve;

/// 编辑配置
@property(nonatomic, strong, readonly) AXKeyboardObserve* ax_keyboardObserve;


@end
