//
//  AXExternFunction.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXExternFunction.h"
#import "AXMacros_log.h"
#import <UIKit/UIKit.h>
#import "UIViewController+AXTool.h"
#import "NSBundle+AXLocal.h"
@implementation AXExternFunction

#pragma mark - Foundation

/**
 是否能打开url
 
 @param url NSString || NSURL
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(id url){
    
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        
        URL = [NSURL URLWithString:url];
        
    }else  if ([url isKindOfClass:URL.class]){
        
        URL = (NSURL *)url;
    }else{
        return NO;
    }
    
    return [[UIApplication sharedApplication] canOpenURL:URL];
}

/**
 * 打开URL
 */
BOOL ax_OpenURLStr(id url) {
    
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        
        URL = [NSURL URLWithString:url];
        
    }else  if ([url isKindOfClass:URL.class]){
        
        URL = (NSURL *)url;
    }else{
        return NO;
    }
    
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        return YES;
        
    } else {
        
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 打开URL NSString || NSURL
 
 @param url NSString || NSURL
 @return BOOL
 */
BOOL ax_OpenURL(id url) {
    
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        
        URL = [NSURL URLWithString:url];
        
    }else  if ([url isKindOfClass:NSURL.class]){
        
        URL = (NSURL *)url;
    }else{
        return NO;
    }
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        return YES;
        
    } else {
        
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString *phone){
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]];
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 拨打电话,直接拨打 拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString *phone){
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}


/**
 xcode 奔溃日志
 */
void ax_LogXcodeCache(void){
    
    NSSetUncaughtExceptionHandler(&ax_uncaughtExceptionHandler);
}

static void ax_uncaughtExceptionHandler(NSException*exception) {
    AXLog(@"↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  xcode运行崩溃  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
    
    AXLog(@"xcode运行崩溃--> %@\n%@", exception, exception.callStackSymbols);
    
    AXLog(@"↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  xcode运行崩溃  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑");
    
}



/**
 * AppStore链接,填写自己的iD
 */
NSString * ax_AppStoreURL(NSString *appId){
    return [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appId];
}

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
NSString * ax_AppStoreScoreURL(NSString *AppStoreID){
    return [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review",AppStoreID];
}

/**
 * int --> NSString
 */
NSString *ax_intToString(int aInt){
    return  [NSString stringWithFormat:@"%d",aInt];
}

/**
 * double --> NSString
 */
NSString *ax_doubleToString(double aDouble){
    return  [NSString stringWithFormat:@"%lf",aDouble];
}

/**
 * double --> NSString
 */
NSString *ax_floatToString(float aFloat){
    return  [NSString stringWithFormat:@"%f",aFloat];
}


/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_randomZeroToValue(int to){
    return arc4random() % to;
}


/**
 * 获取一个随机整数，范围在[from,to），包括from，包括to
 */
int ax_randomFromTo(int from ,int to){
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot(){
    
    NSURL *URL = [NSURL URLWithString:@"prefs:root=General"];
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        return YES;
        
    } else {
        
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 * str to URL
 */
NSURL *ax_URLWithStr(NSString *str){
    
    return [NSURL URLWithString:str];
}

/**
 是debug 环境下
 
 @return 是否
 */
BOOL ax_isDebug(){
    
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
    
}

/**
 是否 iPad
 @return 是否
 */
BOOL ax_isiPad(void){
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        return YES;
    }else{
        return NO;
    }
}


#pragma mark - UIKit

/**
 创建xib
 
 @param name xib 名称
 @return UINib
 */
UINib * ax_Nib(NSString *name){
    return  [UINib nibWithNibName:name bundle:nil];
}

/**
 创建xib
 
 @param aClass xib 名称
 @return UINib
 */
UINib * ax_NibClass(Class aClass){
    
    return  [UINib nibWithNibName:NSStringFromClass(aClass) bundle:nil];
}

/**
 UIImage
 
 @param name 图片名
 @return UIImage
 */
UIImage * ax_Image(NSString *name){
    return  [UIImage imageNamed:name];
}



#pragma mark - 添加属性

/**
 Retain Strong nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setStrongAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id value ) {
    
    objc_setAssociatedObject(object, propertyName,
                             value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 Copy nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setCopyAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id value ) {
    
    objc_setAssociatedObject(object, propertyName,
                             value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 Retain Strong nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setAssignAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id value ) {
    
    objc_setAssociatedObject(object, propertyName,
                             value, OBJC_ASSOCIATION_ASSIGN);
}

/**
 Retain Strong Copy Assign 对象获取值
 Assign 需要转型
 
 @param object 实例
 @param propertyName 属性名 @selector() 格式
 @return id 值
 */
id ax_getAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ) {
    
    return objc_getAssociatedObject(object, propertyName);
    
}


/**
 gcd 创建串行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_SERIAL(const char *_Nullable label) {
    
    return  dispatch_queue_create(label,DISPATCH_QUEUE_SERIAL);
    
}

/**
 gcd 创建并行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_CONCURRENT(const char *_Nullable label) {
    
    return  dispatch_queue_create(label,DISPATCH_QUEUE_CONCURRENT);
    
}

/**
 * Localizable.strings  标准名称 国际化文件
 */
NSString *  AXNSLocalizedString(NSString *key) {
    
    return NSLocalizedString(key,nil);
}

/**
 * AXTools 自定义国际化文件
 */
NSString *  AXToolsLocalizedString(NSString *key) {
    
   NSString *str = [NSBundle.ax_mainBundle localizedStringForKey:key value:@"" table:@"AXToolsLocalizedString"];
    if (str.length == 0) {
        str = NSLocalizedStringFromTable(key,@"AXToolsLocalizedString", @"");
    }
    return str;
}

/**
 状态栏高度
 */
CGFloat AXStatusBarHeight(void) {
    
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

/**
 状态栏高度 和 nav 高度 普通 64 ,x 88
 */
CGFloat AXNavigationBarHeight(UIViewController *aVC) {
    
    return AXStatusBarHeight() + aVC.navigationController.navigationBar.bounds.size.height;
}
/**
 安全区域 insets
 */
UIEdgeInsets AXViewSafeAreInsets(UIView *view) {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if(@available(iOS 11.0, *)) {
        insets = view.safeAreaInsets;
    }
    return insets;
}

/**
 安全区域 bottom
 */
CGFloat AXViewSafeAreBottom(UIView *view){
    
    return  AXViewSafeAreInsets(view).bottom;
}

/**
 安全区域 top
 */
CGFloat AXViewSafeAreTop(UIView *view){
    
    return AXViewSafeAreInsets(view).top;
}

/**
 *  屏幕宽
 */
CGFloat  AXScreenWidth(void) {
    return [UIScreen mainScreen].bounds.size.width;
}

/**
 * 屏幕高
 */
CGFloat  AXScreenHeight(void) {
    return [UIScreen mainScreen].bounds.size.height;
}

/**
 * 当前活动窗口的控制器
 */
UIViewController * AXCurrentViewController(void) {
    return [UIViewController ax_currentViewController];
}

/**
 * app代理
 */
id<UIApplicationDelegate> AXMainAppDelegate(void) {
    return ((id<UIApplicationDelegate>)([UIApplication sharedApplication].delegate));
}

/**
 * app根控制器
 */
UIViewController * AXRootViewController(void) {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

/**
 * AppDelegate app根控制器 个别情况下 AXRootViewController 取值不对
 */
UIViewController * AXRootViewController_AppDelegate(void) {
    
    return  ((id<UIApplicationDelegate>)([UIApplication sharedApplication].delegate)).window.rootViewController;
}

/**
 keyWindow
 */
UIWindow *AXKeyWindow(void) {
   return [UIApplication sharedApplication].keyWindow;
}

/**
 封装NSLog用printf 没有__FILE__ 和 __FILE__
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXNSLog(NSString *format, ...) {
    
#ifdef DEBUG
    
    __block va_list arg_list;
    va_start (arg_list, format);
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    const char *dateChar = dateStr.UTF8String;
    //.m文件名
//    const char *fileChar = [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent.UTF8String;
    //行号
//    int line =  __LINE__;
    //log内容
    const char *formatChar = [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
//    printf("%s [%s 第%d行]: %s\n\n",dateChar, fileChar ,line,formatChar);
     printf("%s : %s\n\n",dateChar,formatChar);
    va_end(arg_list);
    
#else
    
#endif
    
}

/**
 封装NSLog用printf 纯输出
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXNoMsgLog(NSString *format, ...) {
    
#ifdef DEBUG
    
    __block va_list arg_list;
    va_start (arg_list, format);
    //log内容
    const char *formatChar = [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("%s",formatChar);
    va_end(arg_list);
    
#else
    
#endif
    
}

@end
