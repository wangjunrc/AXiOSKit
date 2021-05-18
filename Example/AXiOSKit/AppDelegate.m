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
//#import <LLDebugTool/LLDebug.h>
#import "AXDebugManager.h"
#import <UserNotifications/UserNotifications.h>
#import "_01ContentViewController.h"
#import <LLDynamicLaunchScreen/LLDynamicLaunchScreen.h>
#import "AXShareService.h"

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
/// 接受远程控制的按钮切换,用于接收播放器
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    UIEventSubtype type = event.subtype;
    switch (type) {
            //暂停
        case UIEventSubtypeRemoteControlPause:{
            NSLog(@"暂停");
        }
            break;
            //播放
        case UIEventSubtypeRemoteControlPlay:{
            NSLog(@"播放");
        }
            break;
            //下一首
        case UIEventSubtypeRemoteControlNextTrack:{
            NSLog(@"下一首");
        }
            break;
            //上一首
        case UIEventSubtypeRemoteControlPreviousTrack:{
                NSLog(@"上一首");
            }
            break;
        default:
            break;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    sleep(2);
    
    [self thirdSDKLifecycleManager:@selector(application:didFinishLaunchingWithOptions:) withParameters:@[application,@{}]];
    
    //开启接收远程事件 ,用于接收播放器
//    [application beginReceivingRemoteControlEvents];
    
    //    NSLog(@"IS_PRODUCATION = %d, SERVER_HOST = %@",IS_PRODUCATION, SERVER_HOST);
    //    [LLDynamicLaunchScreen restoreAsBefore];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MakeKeyAndVisible makeKeyAndVisible];
    [self.window makeKeyAndVisible];
    
    
    //    }
    
    //    if (@available(iOS 10.0, *)) {
    //        [self _note];
    //    } else {
    //        // Fallback on earlier versions
    //    }
    //    AXWindowViewController *vc = AXWindowViewController.alloc.init;
    //    vc.view.backgroundColor = UIColor.orangeColor;
    ////    [[LLDebugTool sharedTool] setValue:vc forKeyPath:@"window.rootViewController"];
    //    [[LLDebugTool sharedTool] startWorking];
    //
    //    [[LLDebugTool sharedTool] startWorkingWithConfigBlock:^(LLConfig * _Nonnull config) {
    //
    //           //####################### Color Style #######################//
    //           // Uncomment one of the following lines to change the color configuration.
    //           // config.colorStyle = LLConfigColorStyleSystem;
    //           // [config configBackgroundColor:[UIColor orangeColor] primaryColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
    //
    //           //####################### User Identity #######################//
    //           // Use this line to tag user. More config please see "LLConfig.h".
    //           config.userIdentity = @"Miss L";
    //
    //           //####################### Window Style #######################//
    //           // Uncomment one of the following lines to change the window style.
    //           // config.entryWindowStyle = LLConfigEntryWindowStyleNetBar;
    //
    //       }];
    
    //    [AXDebugManager.sharedManager startInWindow:nil];
    
    
    //    [AXDebugManager.sharedManager startWithHandler:^id<AXDebugUIConfigProtocol> _Nonnull(UIViewController * _Nonnull vc) {
    //        AXDebugUIConfig *config = [AXDebugUIConfig.alloc init];
    //        UIViewController *vc = [UIViewController.alloc init];
    //        vc.view.backgroundColor = UIColor.redColor;
    //        config.rootViewController = vc;
    //        return config;
    //    }];
    //    AXDebugManager.sharedManager.withConfig(^id<AXDebugUIConfigProtocol> _Nonnull(UIViewController * _Nonnull vc) {
    //
    //        AXDebugUIConfig *config = [AXDebugUIConfig.alloc init];
    //        UINavigationController *nav = [UINavigationController.alloc initWithRootViewController:vc];
    //        config.rootViewController = nav;
    //        return config;
    //
    //    }).start();
    
    //    AXDebugManager.sharedManager.start();
    NSLog(@"UIApplicationDidFinishLaunchingNotification====1");
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier{
    
    
    for (UIViewController *vc in self.window.rootViewController.childViewControllers) {
        if ([vc isKindOfClass:UINavigationController.class]) {
            UINavigationController *nav = ( UINavigationController *)vc;
            
            for (UIViewController *vc in nav.childViewControllers) {
                
                if ([vc isKindOfClass:_01ContentViewController.class]) {
                    
                    UITextField *tf = [vc.view viewWithTag:-100];
                    [tf isFirstResponder];
                    
                    if (tf.isEditing) {
                        return NO;
                    }
                    
                    
                    //                    return NO;
                }
            }
        }
    }
    NSLog(@"UIApplicationDidFinishLaunchingNotification====2");
    return YES;
}
-(void)rightBarButtonItemAction:(UIBarButtonItem *)sender {
    
    [AXDebugManager.sharedManager.config.rootViewController dismissViewControllerAnimated:YES completion:nil];
    
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
    
    if ([AXShareService.sharedService  handleOpenUrl:url]) {
        return YES;
    }
    
    [self thirdSDKLifecycleManager:@selector(application:openURL:options:) withParameters:@[application,url?url:@"",options?options:@{}]];
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


// 屏幕旋转方向
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    UIViewController*  topViewController = [self topViewController] ;
    NSLog(@"topViewController = %@",topViewController.class);
    NSLog(@"presentedViewController = %@",window.rootViewController.presentedViewController);
    /// 如果是横屏WebView 支持横屏
    if ([topViewController isKindOfClass:NSClassFromString(@"_38DirectionVC")]){
        
        return   UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight ;
    }
    
    
    return UIInterfaceOrientationMaskPortrait;
    
    //    if ([window.rootViewController.presentedViewController isKindOfClass:NSClassFromString(@"_38DirectionVC")]) {
    //        return   UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight ;
    //        }
    //        else {
    //            return UIInterfaceOrientationMaskPortrait;
    //        }
    
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else {
        return vc;
    }
    return nil;
}
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"用户退出App = %s", __FUNCTION__);
}

/// 清除角标，保留通知栏，不清除通知
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
}



@end
