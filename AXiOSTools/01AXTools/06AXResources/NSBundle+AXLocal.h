//
//  NSBundle+AXLocal.h
//  AXiOSTools
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AXLocal)

+ (NSBundle *)axLocale_bundle;

+ (NSString *)ax_localizedStringForKey:(NSString *)key value:(NSString *)value;
@end

NS_ASSUME_NONNULL_END