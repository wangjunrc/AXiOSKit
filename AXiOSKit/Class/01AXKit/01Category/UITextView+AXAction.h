//
//  UITextView+AXAction.h
//  AXiOSKit
//
//  Created by AXing on 2019/5/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXTextViewDelegateHandler : NSObject <UITextViewDelegate>

@property (nonatomic, weak) UITextView* currentTextView;

/**
 开始编辑
 */
@property (nonatomic, copy) void (^didBeginBlock)(UITextView* textView);

/**
 辑中 textViewDidEndEditing
 */
@property (nonatomic, copy) void (^didEditingChangedBlock)(UITextView* textView);

/**
 结束编辑
 */
@property (nonatomic, copy) void (^didEndBlock)(UITextView* textView);

/**
 是否能输入当前文字
 */
@property (nonatomic, copy) BOOL (^shouldChangeBlock)(UITextView* textView, NSRange range, NSString* text);

/**
 最大输入文字数量
 */
- (void)maxCharacterCount:(NSUInteger)count;

@end

@interface UITextView (AXAction)

/**
 UITextField  代理对象,直接调用block
 例子:
 tf.axDelegateHandler.didBeginBlock = ^(UITextField *textField) {
 
 };
 最好不要用自己做代理,有bug
 */
@property (nonatomic, strong, readonly) AXTextViewDelegateHandler* axDelegateHandler;

@end

NS_ASSUME_NONNULL_END
