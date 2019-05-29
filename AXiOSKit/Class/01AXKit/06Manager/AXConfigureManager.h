//
//  AXConfigureManager.h
//  AXKit
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
+(void)userIQKeyboardManager:(BOOL )user;

/**
 xcode 奔溃日志
 */
+(void)registerCatch;


+(void)UserNotificationCenterConfigure;

@end

NS_ASSUME_NONNULL_END
