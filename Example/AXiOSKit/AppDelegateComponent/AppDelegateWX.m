//
//  AppDelegateWX.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/27.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateWX.h"
#import <WechatOpenSDK/WXApi.h>


#define WXAppId            @"wxb1fbfdf9fe32026b"
@interface AppDelegateWX ()<WXApiDelegate>

@end
@implementation AppDelegateWX

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    //输出微信的log信息
//        [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
//            NSLog(@"输出微信 %@", log);
//        }];
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
    [WXApi registerApp:WXAppId];
    
    return YES;
}

#pragma mark - 第三方分享、登录回调

- (BOOL)application:(UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    NSString *scheme = url.scheme;
    NSString *query = url.query;
    NSLog(@"scheme  =%@,query = %@",scheme,query);
    
    if ([scheme isEqualToString:WXAppId]){
        return [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
    
}


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
