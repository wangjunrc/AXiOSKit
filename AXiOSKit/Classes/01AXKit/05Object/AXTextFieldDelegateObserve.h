//
//  AXTextFieldDelegateObserve.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXTextFieldDelegateObserve : NSObject<UITextFieldDelegate>


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
@property (nonatomic, assign) NSUInteger maxCharacterCount;

///只能输入正正数
@property (nonatomic, assign) BOOL onlyPositiveNumber;

/// 最多只能输入小数 的个数
@property (nonatomic, assign) NSUInteger maxFloatCount;

/// 禁止输入空格
@property (nonatomic, assign) BOOL banBlankSpace;


@end

NS_ASSUME_NONNULL_END
