//
//  AXUNNotificationHandler.m
//  AXiOSKit
//
//  Created by AXing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXUNNotificationHandler.h"

@implementation AXUNNotificationHandler


//iOS10之后 通知回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"收到通知>>>>");
    
//    NSString *identifier = notification.request.identifier;
    UNNotificationPresentationOptions options = UNNotificationPresentationOptionNone; //默认什么也不做，不显示
    //    if (identifier == nil) {
    //        completionHandler(options);
    //        return;
    //    }
    
    //项目中出现过的通知都设置为前台可以显示
    //    if ([identifier isEqualToString:@"timeInterVal"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"pendingRemoval"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"pendingUpdate"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"deliveredRemoval"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"deliveredUpdate"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"category"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"media"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else if ([identifier isEqualToString:@"costomize"]) {
    //        options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //    } else {
    //        options = UNNotificationPresentationOptionNone;
    //    }
    
    options =  UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    //设置完成之后必须调用这个回调，
    completionHandler(options);
}

//iOS10之后  通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSLog(@"点击通知: %@",response.notification.request.content.userInfo);
    
    if ([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
        
        NSLog(@"response.actionIdentifier>> %@",response.notification.request.content.userInfo);
    }
    
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    NSLog(@"categoryIdentifier>> %@",categoryIdentifier);
    
    if (completionHandler) {
        completionHandler();
    }
}


+ (void)registerNotificationCategory API_AVAILABLE(ios(10.0)){
    NSArray *actionsArray = @[
                              [UNTextInputNotificationAction actionWithIdentifier:@"input" title:@"Input" options:UNNotificationActionOptionForeground textInputButtonTitle:@"Send" textInputPlaceholder:@"说点什么吧？"],
                              [UNNotificationAction actionWithIdentifier:@"goodbye" title:@"Goodbye" options:UNNotificationActionOptionForeground],
                              [UNNotificationAction actionWithIdentifier:@"cancel" title:@"Cancel" options:UNNotificationActionOptionForeground]];
    //注意注册的category的标识符为 ljtAction
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"ljtAction" actions:actionsArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    NSArray *actionsArrayUI = @[
                                [UNNotificationAction actionWithIdentifier:@"switch" title:@"Switch" options:UNNotificationActionOptionForeground],
                                [UNNotificationAction actionWithIdentifier:@"open" title:@"Open" options:UNNotificationActionOptionForeground],
                                [UNNotificationAction actionWithIdentifier:@"dismiss" title:@"Dismiss" options:UNNotificationActionOptionForeground]];
    UNNotificationCategory *categoryUI = [UNNotificationCategory categoryWithIdentifier:@"customUI" actions:actionsArrayUI intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    NSSet *set = [NSSet setWithObjects:category,categoryUI,nil];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
}


@end
