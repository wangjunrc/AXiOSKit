//
//  AXCrashProcessManager.h
//  AXiOSKit
//
//  Created by axing on 2019/1/20.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXCrashProcessManager : NSObject

/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)crashProgressWKContentViewCrash;

@end

NS_ASSUME_NONNULL_END
