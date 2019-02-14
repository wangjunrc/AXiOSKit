//
//  AXConfigureManager.h
//  AXTools
//
//  Created by AXing on 2018/12/4.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AXMacros_instance.h"

NS_ASSUME_NONNULL_BEGIN
@interface AXConfigureManager : NSObject

axSharedInstance_H;

/**
 键盘等 基础配置
 */
+(void)configure;

/**
 * 键盘
 */
+(void)IQKeyboardManager;

/**
 xcode 奔溃日志
 */
+(void)registerCatch;


+(void)UserNotificationCenterDelegate __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __OSX_AVAILABLE(10.14);

@end

NS_ASSUME_NONNULL_END
