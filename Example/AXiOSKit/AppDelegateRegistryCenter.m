//
//  SOAComponentAppDelegate.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateRegistryCenter.h"
#import "AppDelegateWCDB.h"
#import "AppDelegateWX.h"
#import "AppDelegateAppearance.h"
#import "AppDelegateWebImage.h"
#import "AppDelegateDebug.h"
@implementation AppDelegateRegistryCenter

#pragma mark - 服务静态注册


- (void)registeServices{
    [self registeService:[AppDelegateWCDB.alloc init]];
    [self registeService:[AppDelegateWX.alloc init]];
    [self registeService:[AppDelegateAppearance.alloc init]];
    [self registeService:[AppDelegateWebImage.alloc init]];
    [self registeService:[AppDelegateDebug.alloc init]];
}

#pragma mark - 获取SOAComponent 单实例
+ (instancetype)instance{
    static AppDelegateRegistryCenter * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDelegateRegistryCenter alloc] init];
        [instance registeServices];
    });
    return instance;
}

#pragma mark - 获取全部服务
//- (NSMutableSet *) services{
//
//
//    if (!_services) {
//        _services = [[NSMutableSet alloc] init];
//        [self registeServices];
//    }
//    return _services;
//}
- (NSMutableSet *)services {
    if (!_services) {
        _services = [NSMutableSet.alloc init];
    }
    return _services;
}

#pragma mark - 服务动态注册
- (void)registeService:(id)service{
//    if (![allServices containsObject:service]) {
        [self.services addObject:service];
//    }
}

@end
