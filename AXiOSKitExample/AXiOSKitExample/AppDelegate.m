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

#define WXAppId            @"wxb1fbfdf9fe32026b"    //App ID

@interface AppDelegate ()<WXApiDelegate>

@end


@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    [UISearchBar.appearance setBarTintColor:UIColor.redColor];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}
     forState:UIControlStateNormal];
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
    return YES;
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

@end
