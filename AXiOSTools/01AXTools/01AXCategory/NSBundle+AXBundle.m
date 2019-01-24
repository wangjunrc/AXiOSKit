//
//  NSBundle+AXBundle.m
//  AXiOSTools
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "NSBundle+AXBundle.h"

/**
 增加这个私有类，目的是不想导入其他的类
 */
@interface AXBundle : NSObject

+ (NSBundle *)ax_mainBundle;

@end


@implementation AXBundle

+ (NSBundle *)ax_mainBundle {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    //spec文件resource_bundles对应的key 
    NSString *bundlePath = [bundle pathForResource:@"AXiOSToolsResource" ofType:@"bundle"];
    NSBundle *ax_mainBundle = [NSBundle bundleWithPath:bundlePath];
    if (ax_mainBundle == nil) {
        ax_mainBundle = bundle;
    }
    return ax_mainBundle;
}

@end

@implementation NSBundle (AXBundle)

+ (NSBundle *)ax_mainBundle {
    return AXBundle.ax_mainBundle;
}


+ (NSBundle *)ax_currentBundleWithName:(NSString *)name {
    NSString *type = @"bundle";
    if ([name.pathExtension isEqualToString:@"bundle"]) {
        type = nil;
    }
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:name ofType:type];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}


@end
