//
//  UITextField+AXAction.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/15.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXKeyboardObserve.h"
#import "AXTextFieldObserve.h"

/// 调用 .ax_delegateHandler.对应属性
@interface UITextField (AXAction)

// UITextField  代理对象,直接调用block
// 例子:
// tf.ax_observe.didBeginBlock = ^(UITextField *textField) {
//
// };
// 最好不要用自己做代理,有bug

/// UITextField 观察者  这里用delegate 实现,可以优化rac实现,不入侵,直接调用block
@property (nonatomic, strong, readonly) AXTextFieldObserve* ax_observe;

/// 编辑配置
@property(nonatomic, strong, readonly) AXKeyboardObserve* ax_keyboardObserve;


@end
