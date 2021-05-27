//
//  AXNumberKeyboardView.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/1/15.
//

#import <UIKit/UIKit.h>
#import "AXNumberKeyboard.h"
NS_ASSUME_NONNULL_BEGIN


@interface AXNumberKeyboardConfig : UIView

/// 键盘类型
@property (nonatomic, assign) AXNumberKeyboardType inputType;
/// 每隔多少个数字空一格
@property (nonatomic, strong) NSNumber *interval;

@property (nonatomic, weak) UITextField *textInput;

@end

@interface AXNumberKeyboardView : UIView

@property(nonatomic, strong,readonly) AXNumberKeyboardConfig *config;

- (instancetype)initWithConfig:(AXNumberKeyboardConfig *)config;

/// 确定回调
@property(nonatomic, copy) void(^handler)(void);

@end

NS_ASSUME_NONNULL_END
