//
//  AXConfigureManager.m
//  AXTools
//
//  Created by AXing on 2018/12/4.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import "AXConfigureManager.h"
#import "AXUNNotificationHandler.h"
#if __has_include("IQKeyboardManager.h")
#import "IQKeyboardManager.h"
#endif

@interface AXConfigureManager ()

@property(nonatomic,strong) AXUNNotificationHandler *notificationhandler API_AVAILABLE(ios(10.0));

@end
@implementation AXConfigureManager

axSharedInstance_M;

/**
 键盘等 基础配置
 */
+(void)configure{
   [self IQKeyboardManager];
}

/**
 * 键盘
 */
+(void)IQKeyboardManager{
    
#if __has_include("IQKeyboardManager.h")
    //拖入工程即生效,这里只是做一下设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用
    manager.enable = YES;
    //控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
#endif
    
}


/**
 xcode 奔溃日志
 */
+(void)registerCatch {
    
    NSSetUncaughtExceptionHandler(&ax_HandleExceptionr);
    signal(SIGABRT, ax_SignalHandler);
    signal(SIGILL, ax_SignalHandler);
    signal(SIGSEGV, ax_SignalHandler);
    signal(SIGFPE, ax_SignalHandler);
    signal(SIGBUS, ax_SignalHandler);
    signal(SIGPIPE, ax_SignalHandler);
}
/**
 * 这里方法只能放类里面,所以用类方法定义
 */
static void ax_HandleExceptionr(NSException*exception) {
    NSLog(@"\n↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  xcode运行崩溃  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
    NSLog(@"xcode运行崩溃--> %@\n%@", exception, exception.callStackSymbols);
    NSLog(@"↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  xcode运行崩溃  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑\n");
}

void ax_SignalHandler(int signal) {
    
}

+(void)UserNotificationCenterDelegate{
    
    if (@available(iOS 10.0, *)) {
        [[AXConfigureManager sharedInstance] UserNotificationCenterDelegate];
    } else {
        
    }
}

-(void)UserNotificationCenterDelegate __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __OSX_AVAILABLE(10.14){
    
    self.notificationhandler = [[AXUNNotificationHandler alloc] init];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self.notificationhandler;
}

/*
 // 以下是设置其他界面
 prefs:root=General&path=About
 prefs:root=General&path=ACCESSIBILITY
 prefs:root=AIRPLANE_MODE
 prefs:root=General&path=AUTOLOCK
 prefs:root=General&path=USAGE/CELLULAR_USAGE
 prefs:root=Brightness
 prefs:root=Bluetooth
 prefs:root=General&path=DATE_AND_TIME
 prefs:root=FACETIME
 prefs:root=General
 prefs:root=General&path=Keyboard
 prefs:root=CASTLE
 prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 prefs:root=General&path=INTERNATIONAL
 prefs:root=LOCATION_SERVICES
 prefs:root=ACCOUNT_SETTINGS
 prefs:root=MUSIC
 prefs:root=MUSIC&path=EQ
 prefs:root=MUSIC&path=VolumeLimit
 prefs:root=General&path=Network
 prefs:root=NIKE_PLUS_IPOD
 prefs:root=NOTES
 prefs:root=NOTIFICATIONS_ID
 prefs:root=Phone
 prefs:root=Photos
 prefs:root=General&path=ManagedConfigurationList
 prefs:root=General&path=Reset
 prefs:root=Sounds&path=Ringtone
 prefs:root=Safari
 prefs:root=General&path=Assistant
 prefs:root=Sounds
 prefs:root=General&path=SOFTWARE_UPDATE_LINK
 prefs:root=STORE
 prefs:root=TWITTER
 prefs:root=FACEBOOK
 prefs:root=General&path=USAGE prefs:root=VIDEO
 prefs:root=General&path=Network/VPN
 prefs:root=Wallpaper
 prefs:root=WIFI
 prefs:root=INTERNET_TETHERING
 prefs:root=Phone&path=Blocked
 prefs:root=DO_NOT_DISTURB
 */

@end
