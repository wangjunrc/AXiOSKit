//
//  SOAComponentAppDelegate.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateRegistryCenter.h"
#import "AppDelegateDB.h"
#import "AppDelegateWX.h"
#import "AppDelegateAppearance.h"
#import "AppDelegateWebImage.h"
#import "AppDelegateDebug.h"
#ifdef DEBUG
#import "AppDelegateURLProtocol.h"
#endif
id AppDelegateRegistry(SEL selector,NSArray *params ) {
    
    //    SEL selector = NSSelectorFromString(selectorStr);
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:AppDelegateRegistryCenter.instance.services.count];
    
    NSObject <UIApplicationDelegate> *service;
    for(service in AppDelegateRegistryCenter.instance.services){
        if ([service respondsToSelector:selector]){
            //注意这里的performSelector这个是要自己写分类的（系统不带这个功能的）
           id result = [service ax_performSelector:selector withObjects:params];
            [resultArray addObject:result];
        }
    }
    
    return resultArray;
}

@implementation AppDelegateRegistryCenter

#pragma mark - 服务静态注册


- (void)registeServices{
    [self registeService:[AppDelegateDB.alloc init]];
    [self registeService:[AppDelegateWX.alloc init]];
    [self registeService:[AppDelegateAppearance.alloc init]];
    [self registeService:[AppDelegateWebImage.alloc init]];
    [self registeService:[AppDelegateDebug.alloc init]];
#ifdef DEBUG
    [self registeService:AppDelegateURLProtocol.alloc.init];
#endif
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
