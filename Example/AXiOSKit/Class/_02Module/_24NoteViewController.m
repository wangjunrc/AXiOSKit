//
//  _24NoteViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/12.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_24NoteViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <UserNotifications/UserNotifications.h>

@interface _24NoteViewController ()

@end

@implementation _24NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地推送通知";
    self.view.backgroundColor = UIColor.whiteColor;
    [self _note];
}

-(void)_note {
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"通知" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    __weak typeof(self) weakSelf = self;
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (@available(iOS 10.0, *)) {
            [strongSelf addLocalNotification];
        }
    }];
    
}



- (void)addLocalNotification API_AVAILABLE(ios(10.0)) {
    //创建通知
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"通知标题";
    content.subtitle = @"通知副标题";
    content.body = @"通知内容";
    content.badge = @1;//角标数
    content.categoryIdentifier = @"categoryIdentifier";
    
    //声音设置 [UNNotificationSound soundNamed:@"sound.mp3"] 通知文件要放到bundle里面
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    //添加附件
    //maxinum 10M
    //    NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    
    
    //maxinum 5M
    //    NSString *audioFile = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"mp3"];
    //maxinum 50M
    //NSString *movieFile = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    
    //    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"iamgeAttachment" URL:[NSURL fileURLWithPath:imageFile] options:nil error:nil];
    //    UNNotificationAttachment *audioAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"audioAttachment" URL:[NSURL fileURLWithPath:audioFile] options:nil error:nil];
    //    //添加多个只能显示第一个
    //    content.attachments = @[audioAttachment,imageAttachment];
    
    /** 通知触发机制
     Trigger 设置本地通知触发条件,它一共有以下几种类型：
     UNPushNotificaitonTrigger 推送服务的Trigger，由系统创建
     UNTimeIntervalNotificationTrigger 时间触发器，可以设置多长时间以后触发，是否重复。如果设置重复，重复时长要大于60s
     UNCalendarNotificationTrigger 日期触发器，可以设置某一日期触发
     UNLocationNotificationTrigger 位置触发器，用于到某一范围之后，触发通知。通过CLRegion设定具体范围。
     */
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
    
    //创建UNNotificationRequest通知请求对象
    NSString *requestIdentifier = @"requestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    //将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}
// 取消通知
- (void)cancelLocalNotificaitons API_AVAILABLE(ios(10.0)) {
    
    //获取未展示的通知
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"requestIdentifier"]];
    }];
    
    //获取展示过的通知
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[@"requestIdentifier"]];
    }];
    
    //移除所有还未展示的通知
    //[[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    //移除所有已经展示过的通知
    //[[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
}

-(void)dealloc {
    if (@available(iOS 10.0, *)) {
        [self cancelLocalNotificaitons];
    }
}

@end
