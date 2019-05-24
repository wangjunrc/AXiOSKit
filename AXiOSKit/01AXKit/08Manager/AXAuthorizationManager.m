//
//  AXAuthorizationManager.m
//  AXiOSKit
//
//  Created by AXing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXAuthorizationManager.h"
#import "UserNotifications/UserNotifications.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface AXAuthorizationManager ()

@property(nonatomic,strong)CLLocationManager *locationManager;

@end
@implementation AXAuthorizationManager

/**
 用户通知授权状态
 */
-(void)noticeAuthorizationState:(void(^)(BOOL success))block {
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined){
                NSLog(@"未选择---没有选择允许或者不允许，按不允许处理");
                if (block) {
                    block(NO);
                }
            }else if (settings.authorizationStatus == UNAuthorizationStatusDenied){
                NSLog(@"未授权--不允许推送");
                if (block) {
                    block(NO);
                }
            }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                NSLog(@"已授权--允许推送");
                if (block) {
                    block(YES);
                }
            }else if (@available(iOS 12.0, *)) {
                
                if (settings.authorizationStatus == UNAuthorizationStatusProvisional){
                    NSLog(@"不知道什么状态--允许推送");
                    if (block) {
                        block(YES);
                    }
                }
            }
            
        }];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        BOOL isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
        if (block) {
            block(isEnable);
        }
#pragma clang diagnostic pop
       
        
    }
}

/**
 用户通知授权
 */
-(void)noticeAuthorization {
    
    if (@available(iOS 10.0,*)) {

        UNAuthorizationOptions options = UNAuthorizationOptionAlert |UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
        [center requestAuthorizationWithOptions: options completionHandler:^(BOOL granted, NSError *__nullable error){
            if (granted) {
                NSLog(@"通知开通成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            } else {
                NSLog(@"通知开通失败");
            }
        }];
    }else{

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationType types = UIUserNotificationTypeAlert| UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        /*查看是否授权成功*/
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        BOOL isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
#pragma clang diagnostic pop

    }
}


/**
 用户定位授权
 */
-(void)locationAuthorization {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    
    //都调用,才能在设置里面看见选项
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }

    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    
}

@end
