//
//  AXConfigureFunction.h
//  AXTools
//
//  Created by AXing on 2018/12/4.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXConfigureFunction : NSObject

/**
 键盘等 基础配置
 */
void ax_configure(void);

/**
 * 键盘
 */
void ax_IQKeyboardManager(void);

/**
 xcode 奔溃日志
 */
void ax_registerCatch(void);

@end

NS_ASSUME_NONNULL_END
