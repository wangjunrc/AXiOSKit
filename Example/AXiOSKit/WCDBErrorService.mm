//
//  JPushService.m
//  ALDNews
//
//  Created by Allen  on 2018/4/24.
//  Copyright © 2018年 Aladdin. All rights reserved.
//

#import "WCDBErrorService.h"
#import <WCDB/WCDB.h>
@interface WCDBErrorService()

@end

@implementation WCDBErrorService

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"WCDBErrorService====didFinishLaunchingWithOptions application = %@, launchOptions = %@ ",application,launchOptions);
    
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
@end

