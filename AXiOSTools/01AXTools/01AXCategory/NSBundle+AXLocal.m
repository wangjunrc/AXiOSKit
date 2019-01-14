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
@interface AXBundle : NSObject

+ (NSBundle *)ax_mainBundle;

@end


@implementation AXBundle

+ (NSBundle *)ax_mainBundle {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    //spec文件resource_bundles对应的key 
    NSString *bundlePath = [bundle pathForResource:@"AXiOSTools_ax_mainBundle" ofType:@"bundle"];
    NSBundle *ax_mainBundle = [NSBundle bundleWithPath:bundlePath];
    if (ax_mainBundle == nil) {
        ax_mainBundle = bundle;
    }
    return ax_mainBundle;
}

@end

@implementation NSBundle (AXLocal)

+ (NSBundle *)ax_mainBundle {
    return [AXBundle ax_mainBundle];
}


@end
