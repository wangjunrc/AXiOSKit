//
//  AXUNNotificationHandler.h
//  AXiOSKit
//
//  Created by AXing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserNotifications/UserNotifications.h"

NS_ASSUME_NONNULL_BEGIN

__IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __OSX_AVAILABLE(10.14)

@interface AXUNNotificationHandler  : NSObject<UNUserNotificationCenterDelegate>

+ (void)registerNotificationCategory;

@end

NS_ASSUME_NONNULL_END
