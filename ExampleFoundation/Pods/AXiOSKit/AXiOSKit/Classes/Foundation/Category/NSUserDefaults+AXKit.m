//
//  NSUserDefaults+AXKit.m
//  BigApple
//
//  Created by liuweixing on 2017/7/10.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "NSUserDefaults+AXKit.h"

@implementation NSUserDefaults (AXKit)

/**
 删除所有的 NSUserDefaults
 */
+(void)ax_removeAllKey{

    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
