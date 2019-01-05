//
//  NSBundle+AXLocal.m
//  AXiOSTools
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "NSBundle+AXLocal.h"

/**
 增加这个私有类，目的是不想导入其他的类
 */
@interface AXLocalBundle : NSObject

+ (NSBundle *)axLocale_bundle;

@end


@implementation AXLocalBundle

+ (NSBundle *)axLocale_bundle {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [bundle pathForResource:@"AXiOSTools_bundle_base" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
    return imageBundle;
}

@end

@implementation NSBundle (AXLocal)

+ (NSBundle *)axLocale_bundle {
    return [AXLocalBundle axLocale_bundle];
}

+ (NSString *)ax_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle axLocale_bundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
@end
