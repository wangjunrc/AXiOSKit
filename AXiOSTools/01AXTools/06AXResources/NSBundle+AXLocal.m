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
    NSString *bundlePath = [bundle pathForResource:@"AXiOSTools" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
    return imageBundle;
}

@end

@implementation NSBundle (AXLocal)

+ (NSBundle *)axLocale_bundle {
    return [AXLocalBundle axLocale_bundle];
}

@end
