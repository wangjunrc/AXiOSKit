//
//  JPushService.m
//  ALDNews
//
//  Created by Allen  on 2018/4/24.
//  Copyright © 2018年 Aladdin. All rights reserved.
//

#import "AppDelegateWCDB.h"
#import <WCDB/WCDB.h>
#import <MMKV/MMKV.h>
#import <AXiOSKit/AXiOSKit.h>
#import "RPDataBase.h"

@interface AppDelegateWCDB()

@end

@implementation AppDelegateWCDB

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"WCDBErrorService====didFinishLaunchingWithOptions application = %@, launchOptions = %@ ",application,launchOptions);
    
    [self configWCDB];
    [self configMMKV];
    [self configRealm];
    
    return YES;
}



//注册Token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
   
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
   
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional

    
}

//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
  
    
    
}
-(void)configWCDB {
    /// WCDB 监控
    //Error Monitor
    [WCTStatistics SetGlobalErrorReport:^(WCTError *error) {
        NSLog(@"[WCDB] error %@", error);
    }];
    
    
    //Performance Monitor
    [WCTStatistics SetGlobalPerformanceTrace:^(WCTTag tag, NSDictionary<NSString *, NSNumber *> *sqls, NSInteger cost) {
        NSLog(@"[WCDB] Database with tag:%d", tag);
        NSLog(@"[WCDB] Run :");
        [sqls enumerateKeysAndObjectsUsingBlock:^(NSString *sqls, NSNumber *count, BOOL *) {
            NSLog(@"[WCDB] SQL %@ %@ times", sqls, count);
        }];
        NSLog(@"[WCDB] Total cost %ld nanoseconds", (long)cost); }];
    
    
    //SQL Execution Monitor
    [WCTStatistics SetGlobalSQLTrace:^(NSString *sql) {
        NSLog(@"[WCDB] SQL: %@", sql);
    }];
}

-(void)configMMKV {
    NSString *path = [NSString.ax_documentPath stringByAppendingPathComponent:@"AX_MMKV"];
    [MMKV initializeMMKV:path];
}

-(void)configRealm{
    
#if __has_include(<Realm/Realm.h>)
    [RPDataBase  dataBaseMigration];
#endif
}


@end

