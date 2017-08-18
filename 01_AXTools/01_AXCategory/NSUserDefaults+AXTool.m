//
//  NSUserDefaults+AXTool.m
//  BigApple
//
//  Created by Mole Developer on 2017/7/10.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "NSUserDefaults+AXTool.h"

@implementation NSUserDefaults (AXTool)

/**
 删除所有的 NSUserDefaults
 */
+(void)ax_removeAllKey{

    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
