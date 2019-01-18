//
//  AXConfigureFunction.m
//  AXTools
//
//  Created by AXing on 2018/12/4.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import "AXConfigureFunction.h"

#if __has_include("IQKeyboardManager.h")
#import "IQKeyboardManager.h"
#endif

@implementation AXConfigureFunction

/**
 键盘等 基础配置
 */
void ax_configure(void) {
    ax_IQKeyboardManager();
}

/**
 * 键盘
 */
void ax_IQKeyboardManager(void) {
    
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
void ax_registerCatch(void){
    
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
    
    /**把异常崩溃信息上传服务器*/
    //    int32_t exceptionCount = OSAtomicIncrement32(0);
    //    if (exceptionCount > 10) {
    //        return;
    //    }
    //    NSString *callStack = [BSBacktraceLogger bs_backtraceOfAllThread];
    //    NSMutableDictionary *exceptionInfo = [NSMutableDictionary dictionary];
    //    [exceptionInfo setValue:exception forKey:@"exception"];
    //    [exceptionInfo setValue:callStack forKey:@"callStack"];
    //    [[SPTCrashHelper sharedHelper] performSelectorOnMainThread:@selector(handleException:) withObject:exceptionInfo waitUntilDone:YES];
    
}

void ax_SignalHandler(int signal) {
    
    //    int32_t exceptionCount = OSAtomicIncrement32(&ax_HandleExceptionr);
    //
    //    if (exceptionCount > 10) {
    //        return;
    //    }
    //
    //    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //    userInfo[@"UncaughtExceptionHandlerSignalKey"] = @(signal);
    //
    //
    //    NSException *exception = [NSException
    //                              exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
    //                              reason:
    //                              [NSString stringWithFormat:
    //                               NSLocalizedString(@"Signal %d was raised.", nil),
    //                               signal]
    //                              userInfo:userInfo];
    //
    //    NSString *callStack = [BSBacktraceLogger bs_backtraceOfAllThread];
    //
    //    NSMutableDictionary *exceptionInfo = [NSMutableDictionary dictionary];
    //    [exceptionInfo setValue:exception forKey:@"exception"];
    //    [exceptionInfo setValue:callStack forKey:@"callStack"];
    //
    //
    //    [[SPTCrashHelper sharedHelper] performSelectorOnMainThread:@selector(handleException:) withObject:exceptionInfo waitUntilDone:YES];
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
