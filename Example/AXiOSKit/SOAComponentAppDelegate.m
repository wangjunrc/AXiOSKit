//
//  SOAComponentAppDelegate.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "SOAComponentAppDelegate.h"
#import "AppDelegateWCDB.h"
#import "AppDelegateWX.h"
#import "AppDelegateAppearance.h"
@implementation SOAComponentAppDelegate

#pragma mark - 服务静态注册

//根据项目要求 添加相应的服务。现在只添加JPush
- (void)registeServices{
    [self registeService:[AppDelegateWCDB.alloc init]];
    [self registeService:[AppDelegateWX.alloc init]];
    [self registeService:[AppDelegateAppearance.alloc init]];
}

#pragma mark - 获取SOAComponent 单实例
+ (instancetype)instance{
    static SOAComponentAppDelegate * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SOAComponentAppDelegate alloc] init];
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
