//
//  NSBundle+AXBundle.h
//  AXiOSTools
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AXBundle)


/**
 AXiOSToolsResource.bundle 路径

 @return NSBundle
 */
+ (NSBundle *)ax_mainBundle;


/**
 当前 Bundle

 @param name Bundle名
 @return NSBundle
 */
+ (NSBundle *)ax_currentBundleWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
