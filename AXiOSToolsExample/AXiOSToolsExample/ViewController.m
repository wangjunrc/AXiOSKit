//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//




#import "ViewController.h"

#import "ABViewController.h"
#import "AXiOSTools.h"

#import "AAViewController.h"
#import "AView.h"
#import "AView.h"

@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    AView *aview = [[AView alloc]init];
    [self.view addSubview:aview];
    aview.backgroundColor = [UIColor grayColor];
    
    [aview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(200);
         make.left.mas_equalTo(20);
         make.size.mas_equalTo(CGSizeMake(200, 200));
        
    }];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AAViewController *avc = [[AAViewController alloc]init];
//    avc.vc = self;
    avc.did = ^{
        self.view.backgroundColor = [UIColor redColor];
    };
    self.avc = avc;
    [self.navigationController pushViewController:avc animated:YES];
    
}
- (IBAction)btnAction:(id)sender {
    
//    [self ax_revolveOrientation:UIInterfaceOrientationLandscapeRight];
    
    // 1. 创建消息上要添加的动作，以按钮的形式显示
    // 1.1 接受按钮
    UIMutableUserNotificationAction *acceptAction = [UIMutableUserNotificationAction new];
    acceptAction.identifier = @"acceptAction"; // 添加标识
    acceptAction.title = @"接受"; // 设置按钮上显示的文字
    acceptAction.activationMode = UIUserNotificationActivationModeForeground; // 当点击的时候启动程序
    
    // 1.2 拒绝按钮
    UIMutableUserNotificationAction *rejectAction = [UIMutableUserNotificationAction new];
    rejectAction.identifier = @"rejectAction";
    rejectAction.title = @"拒绝";
    rejectAction.activationMode = UIUserNotificationActivationModeBackground; // 当点击的时候不启动程序
    rejectAction.authenticationRequired = YES; // 需要解锁才能处理，如果 rejectAction.activationMode = UIUserNotificationActivationModeForeground; 那么这个属性将被忽略
    rejectAction.destructive = YES; // 按钮事件是否是不可逆转的
    
    
    
    // 2. 创建动作的类别集合
    UIMutableUserNotificationCategory *categorys = [UIMutableUserNotificationCategory new];
    categorys.identifier = @"alert"; // 动作集合的标识
    [categorys setActions:@[acceptAction, rejectAction]
               forContext:UIUserNotificationActionContextMinimal]; // 把两个按钮添加到动作的集合中，并设置上下文样式
    
    // 3. 创建UIUserNotificationSettings，并设置消息的显示类型
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    
    // 4. 注册通知
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    UILocalNotification *loc = [[UILocalNotification alloc] init];
    
    
    
    if (@available(iOS 8.2, *)) {
        loc.alertTitle = @"alertTitle";
    } else {
    }
    
    loc.alertBody = @"ios10前alertBody";
    // 锁屏界面显示的小标题(完整小标题:“滑动来” + alertAction)
    loc.alertAction = @"查看消息";
    loc.soundName = UILocalNotificationDefaultSoundName;
    loc.alertLaunchImage = @"onevcat" ;
    loc.category = @"alert";
    //立即触发一个通知
    //            [[UIApplication sharedApplication] presentLocalNotificationNow:loc];
    
    
    loc.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    loc.timeZone = [NSTimeZone defaultTimeZone];
    //    loc.repeatInterval = NSCalendarUnitSecond;
    //调度本地推送通知(调度完毕后,推送通知会在特地时间fireDate发出)
    
    [[UIApplication sharedApplication] scheduleLocalNotification:loc];
    NSLog(@"IOS10以前发送通知");
    
}



@end
