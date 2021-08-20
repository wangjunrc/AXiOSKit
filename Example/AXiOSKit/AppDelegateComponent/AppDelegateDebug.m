//
//  AppDelegateDebug.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/14.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateDebug.h"
#if __has_include(<CocoaDebug/CocoaDebugTool.h>)
@import CocoaDebug;
#endif

#if __has_include(<YYDebugDatabase/DebugDatabaseManager.h>)
#import <YYDebugDatabase/DebugDatabaseManager.h>
#endif


#if __has_include(<DoraemonKit/DoraemonKit.h>)
#import <DoraemonKit/DoraemonKit.h>
#endif


#import "DemoEnvironmenVC.h"
//#import <AvoidCrash/AvoidCrash.h>
#import <JJException/JJException.h>


@interface AppDelegateDebug()<JJExceptionHandle>

@end

@implementation AppDelegateDebug

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self configCocoaDebug];
    [self configDoraemonKit];
#if DEBUG
    /// 只能模拟器
    /// for iOS
    //    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    //    /// for tvOS
    //    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
    //    /// for masOS
    //    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
#endif
    
#if __has_include(<YYDebugDatabase/DebugDatabaseManager.h>)
    // http://127.0.0.1:9002 模拟器用
    // http://192.168.31.10:9002/# 真机用 手机的ip, 在手机网络详情里 ip地址
    [DebugDatabaseManager.shared startServerOnPort:9002];
#endif
    
/**
 #ifdef 表示是否定义
 #if 表示定义的值用于比较,可以多种情况
 */
#ifdef DEBUG
    NSLog(@"当前环境 = Debug");
    // Debug_α Debug_β 都属于 DEBUG 内
#ifdef Debug_α
    NSLog(@"当前环境 = Debug_α");
#elif Debug_β
    NSLog(@"当前环境 = Debug_β");
#endif
    
#endif
    
#ifdef TARGET_IPHONE_SIMULATOR
    // 模拟器
    AXLoger(@"模拟器");
#elif TARGET_OS_IPHONE
    // 真机
    AXLoger(@"真机");
#endif
    
#ifdef IS_PRODUCATION
    NSLog(@"IS_PRODUCATION = %d",IS_PRODUCATION);
#endif
    
#ifdef SERVER_HOST
    NSLog(@"SERVER_HOST = %@", SERVER_HOST);
#endif
    
#ifdef SERVER_PORT
    NSLog(@"SERVER_PORT = %@",SERVER_PORT);
#else
    NSLog(@"没有定义 SERVER_PORT");
#endif
    
    //    [AvoidCrash makeAllEffective];
    //
    //    NSArray *noneSelClassStrings = @[
    //        @"NSNull",
    //        @"NSNumber",
    //        @"NSString",
    //        @"NSDictionary",
    //        @"NSArray"
    //    ];
    //    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    //
    //    /**
    //     *  相比于becomeEffective，增加
    //     *  对”unrecognized selector sent to instance”防止崩溃的处理
    //     *
    //     *  但是必须配合:
    //     *            setupClassStringsArr:和
    //     *            setupNoneSelClassStringPrefixsArr
    //     *            这两个方法可以同时使用
    //     */
    //    //    + (void)makeAllEffective;
    //
    //    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
    [JJException configExceptionCategory:JJExceptionGuardAll];
    [JJException startGuardException];
    
    [JJException registerExceptionHandle:self];
    return YES;
}

- (void)handleCrashException:(NSString*)exceptionMessage
           exceptionCategory:(JJExceptionGuardCategory)exceptionCategory
                   extraInfo:(nullable NSDictionary*)info{
    NSLog(@"_监测到奔溃 exceptionMessage=%@,exceptionCategory=%ld,info=%@",exceptionMessage,exceptionCategory,info);
    
    
}
- (void)handleCrashException:(nonnull NSString *)exceptionMessage extraInfo:(nullable NSDictionary *)info {
    NSLog(@"_监测到奔溃1 exceptionMessage=%@,info=%@",exceptionMessage,info);
    
    [ax_currentViewController() ax_showAlertByTitle:[NSString stringWithFormat:@"监测到奔溃2=%@",exceptionMessage]];
}



- (void)configCocoaDebug{
    
    
#if __has_include(<CocoaDebug/CocoaDebugTool.h>)
//    [CocoaDebug enable];
    //        //--- If Want to Custom CocoaDebug Settings ---
    //        CocoaDebug.serverURL = @"google.com";
    //        CocoaDebug.ignoredURLs = @[@"aaa.com", @"bbb.com"];
    //        CocoaDebug.onlyURLs = @[@"ccc.com", @"ddd.com"];
    //        CocoaDebug.ignoredPrefixLogs = @[@"aaa", @"bbb"];
    //        CocoaDebug.onlyPrefixLogs = @[@"ccc", @"ddd"];
    CocoaDebug.logMaxCount = 1000;
    //        CocoaDebug.emailToRecipients = @[@"aaa@gmail.com", @"bbb@gmail.com"];
    //        CocoaDebug.emailCcRecipients = @[@"ccc@gmail.com", @"ddd@gmail.com"];
            CocoaDebug.mainColor = @"#7FFFAA";
    CocoaDebug.additionalViewController = [DemoEnvironmenVC.alloc init];
    //
    //        //--- If Use Google's Protocol buffers ---
    //        CocoaDebug.protobufTransferMap = @{
    //            @"your_api_keywords_1": @[@"your_protobuf_className_1"],
    //            @"your_api_keywords_2": @[@"your_protobuf_className_2"],
    //            @"your_api_keywords_3": @[@"your_protobuf_className_3"]
    //        };
#endif
}

//配置Doraemon工具集
- (void)configDoraemonKit{
#if __has_include(<DoraemonKit/DoraemonKit.h>)
    [[DoraemonManager shareInstance] addPluginWithTitle:@"环境切换" icon:@"doraemon_default" desc:@"用于app内部环境切换功能" pluginName:@"TestPlugin" atModule:@"业务专区"];
    [DoraemonManager shareInstance].bigImageDetectionSize = 10 * 1024;//大图检测只检测10K以上的
    [[DoraemonManager shareInstance] addH5DoorBlock:^(NSString *h5Url) {
        //        [APP_INTERACOTR.rootNav openURL:@"KDSJ://KDWebViewController" withQuery:@{@"urlString":h5Url}];
    }];
    [[DoraemonManager shareInstance] installWithPid:@"25896f0ba25381c74c519063f83bba8a"];
    
#endif
}

@end




