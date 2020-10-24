//
//  AppDelegate.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/6.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "AppDelegate.h"
#import "MakeKeyAndVisible.h"
#import <WechatOpenSDK/WXApi.h>
#import <UserNotifications/UserNotifications.h>
#define WXAppId            @"wxb1fbfdf9fe32026b"    //App ID
#import <Bagel/Bagel.h>

@interface AppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>

@end


@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    BagelConfiguration  *bagelConfig = [[BagelConfiguration alloc]init];
//
//    bagelConfig.project.projectName = @"Custom Project Name";
//    bagelConfig.device.deviceName = @"Custom Device Name";
//    bagelConfig.device.deviceDescription = @"Custom Device Description";
//    
//    
//    [Bagel start:bagelConfig];
    //    [UISearchBar.appearance setBarTintColor:UIColor.redColor];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}
     forState:UIControlStateNormal];
    
    // 修改message字体及颜色
//    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message];
//    [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithHexString:@"#E02020"] range:NSMakeRange(0, messageStr.length)];
//    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
//    [alertController setValue:messageStr forKey:@"attributedMessage"];
    
    /// 按钮颜色
//    [UIView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.redColor;
    
    
//    [UIView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.redColor;
//    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class,UIAlertView.class]].textColor = UIColor.redColor;
//    
//    //实现模糊效果
//       UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//       //毛玻璃视图
//       UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
//      
//    
////    @property (nonatomic, copy, nullable) UIVisualEffect *effect;
////    [UIVisualEffectView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].effect = effectView;
//    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].textColor = UIColor.orangeColor;
//    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.greenColor;
//    
//    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:@"AA"];
//    [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor orangeColor] range:NSMakeRange(0, messageStr.length)];
//    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
////    [alertController setValue:messageStr forKey:@"attributedMessage"];
//    
//    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].backgroundColor =UIColor.orangeColor;
   
    
    
    //    [UIBarButtonItem.appearance setTintColor:UIColor.redColor];;
    //    [UIButton.appearance setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    //    [UIButton.appearance setBackgroundColor:UIColor.grayColor];
    
    
    
    //    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setBackgroundColor:[UIColor clearColor]];
    
    //    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UIViewController class]]] setBackgroundColor:[UIColor grayColor]];
    //    //输出微信的log信息
    //    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
    //        NSLog(@"输出微信 %@", log);
    //    }];
    //
    //    if([WXApi registerApp:WXAppId universalLink:@"https://wwwtest.asiacoat.com/"]){
    //        NSLog(@"初始化成功");
    //    }
    //
    //
    //
    //    //自检函数
    //    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
    //        NSLog(@"自检函数 = %@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
    //    }];
    
    //获取document路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    //文件名及其路径
    NSString *fileName = @"test.txt";
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //建立一个char数组，并归档写入到沙盒中
    char *a = "hello, world";
    NSData *data = [NSData dataWithBytes:a length:12];
    [data writeToFile:filePath atomically:YES];
    
    [WXApi registerApp:WXAppId];
    
    
    //    if (@available(iOS 13, *)) {
    //    } else {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MakeKeyAndVisible makeKeyAndVisible];
    [self.window makeKeyAndVisible];
    //    }
    [self adapterIOS11];
//    if (@available(iOS 10.0, *)) {
//        [self _note];
//    } else {
//        // Fallback on earlier versions
//    }
    return YES;
}

- (void)adapterIOS11{
    // 适配iOS11以上UITableview 、UICollectionView、UIScrollview 列表/页面偏移
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
    }
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
    
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark Universal Link
//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
//    
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
//}

//注意：微信和QQ回调方法用的是同一个，这里注意判断resp类型来区别分享来源
- (void)onResp:(id)resp{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){//微信回调
        
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        
        if(response.errCode == WXSuccess){
            //目前分享回调只会走成功
            NSLog(@"分享完成");
        }
    }else if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            NSLog(@"微信登录完成，code：%@", req.code);//获取到第一步code
        }
    }
    //    else if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]]){
    //
    //        WXLaunchMiniProgramResp *req = (WXLaunchMiniProgramResp *)resp;
    //        NSLog(@"%@", req.extMsg);// 对应JsApi navigateBackApplication中的extraData字段数据
    //    }
}

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


@end