//
//  AppDelegate.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/6.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegateWCDB.h"
#import "MakeKeyAndVisible.h"
#import "AppDelegateRegistryCenter.h"
#import <Bagel/Bagel.h>
#import <LLDebugTool/LLDebug.h>
#import <UserNotifications/UserNotifications.h>

#if ENV == 1
#import "URI_Env_1.h"
#else
#import "URI.h"
#endif


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end


@implementation AppDelegate

-(void)thirdSDKLifecycleManager:(SEL )selector withParameters:(NSArray *)params{
    
    //    SEL selector = NSSelectorFromString(selectorStr);
    NSObject <UIApplicationDelegate> *service;
    for(service in [[AppDelegateRegistryCenter instance] services]){
        if ([service respondsToSelector:selector]){
            //注意这里的performSelector这个是要自己写分类的（系统不带这个功能的）
            [service ax_performSelector:selector withObjects:params];
            
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self thirdSDKLifecycleManager:@selector(application:didFinishLaunchingWithOptions:) withParameters:@[application,@{}]];
    NSLog(@"环境 ==== PATH %@",PATH);
#if ENV == 1
    NSLog(@"环境 ==== 1");
#else
    NSLog(@"环境 ==== 默认");
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MakeKeyAndVisible makeKeyAndVisible];
    [self.window makeKeyAndVisible];
    //    }
    
    //    if (@available(iOS 10.0, *)) {
    //        [self _note];
    //    } else {
    //        // Fallback on earlier versions
    //    }
    
    return YES;
}

-(void)_note __IOS_AVAILABLE(10.0) {
    //注册本地推送
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    
    //获取当前的通知设置
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //获取共享的UserDefaults
    NSString *suitName = @"group.com.ax.kit";
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suitName];
    if ([userDefaults boolForKey:@"has-new-share"]) {
        //获取分组的共享目录
        NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:suitName];
        NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"incomingShared"];
        NSData *dictData = [[NSData alloc ]initWithContentsOfURL:fileURL];
        NSMutableArray *dicts = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        //读取文件
        for (NSDictionary *dict in dicts) {
            //            UIImage *image = [[UIImage alloc]initWithData:dict[@"image"]];
            NSString *name = dict[@"text"];
            NSLog(@"name = %@",name);
            //拿到数据了哈哈后
        }
        [[NSFileManager defaultManager]removeItemAtURL:fileURL error:NULL];
        //重置分享标识
        [userDefaults setBool:NO forKey:@"has-new-share"];
    }
}


#pragma mark - 第三方分享、登录回调
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [self thirdSDKLifecycleManager:@selector(application:openURL:options:) withParameters:@[application,url?url:@"",options?options:@""]];
    return YES;
}

#pragma mark Universal Link
//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
//    
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
//}

//注意：微信和QQ回调方法用的是同一个，这里注意判断resp类型来区别分享来源

#pragma mark - <UNUserNotificationCenterDelegate>
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"点击通知");
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

//iOS10之后  通知的点击事件
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
//
//    NSLog(@"点击通知: %@",response.notification.request.content.userInfo);
//
//    if ([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
//
//        NSLog(@"response.actionIdentifier>> %@",response.notification.request.content.userInfo);
//    }
//
//    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
//
//    NSLog(@"categoryIdentifier>> %@",categoryIdentifier);
//
//    if (completionHandler) {
//        completionHandler();
//    }
//}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    // UNNotificationCategory
    if ([categoryIdentifier isEqualToString:@"categoryIdentifier"]) {
        // UNNotificationAction、UNTextInputNotificationAction
        if ([response.actionIdentifier isEqualToString:@"cancelAction"]) {
            
        }
    }
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    if ([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
        
        NSLog(@"response.actionIdentifier>> %@",response.notification.request.content.userInfo);
    }
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"点击 iOS10 远程通知");
    } else {
        // 本地通知
        NSLog(@"点击 iOS10 本地通知");
    }
    
    if (completionHandler) {
        completionHandler();
    }
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"用户退出App = %s", __FUNCTION__);
}

@end
