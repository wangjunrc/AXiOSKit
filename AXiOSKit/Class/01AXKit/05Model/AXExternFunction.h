//
//  AXExternFunction.h
//  AXiOSKitDemo
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 是debug 环境下

 @return 是否
 */
BOOL ax_isDebug(void);

/**
 是否 iPad
 @return 是否
 */
BOOL ax_isiPad(void);

/**
 * AppStore链接,填写自己的iD
 */
NSString *ax_AppStoreURL(NSString *appId);

/**
 AppStore 评分 url

 @param AppStoreID AppStoreID
 @return url String
 */
NSString *ax_AppStoreScoreURL(NSString *AppStoreID);

/**
 拨打电话,直接拨打

 @param phone 号码

 @return 是否成功
 */
BOOL ax_CallTel(NSString *phone);

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot(void);

/**
 是否能打开url

 @param url url str

 @return 是否打开
 */
BOOL ax_CanOpenURL(id url);

/**
 打开url

 @param url url str

 @return 打开是否成功
 */
BOOL ax_OpenURLStr(id _Nonnull url);

/**
 打开URL NSString || NSURL

 @param url NSString || NSURL
 @return BOOL
 */
BOOL ax_OpenURL(id _Nonnull url);

/**
 拨打电话,弹出alert界面

 @param phone 号码

 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString *phone);

/**
 * URL With str
 */
NSURL *ax_URLWithStr(NSString *str);

/**
 * int --> NSString
 */
NSString *ax_intToString(int aInt);

/**
 * double --> NSString
 */
NSString *ax_doubleToString(double aDouble);

/**
 * double --> NSString
 */
NSString *ax_floatToString(float aFloat);

/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_randomZeroToValue(int to);

/**
 * 获取一个随机整数，范围在[from,t]，包括from，包括to
 */
int ax_randomFromTo(int from, int to);

#pragma mark - UIKit

/**
 创建xib With xib 名称

 @param name xib 名称
 @return UINib
 */
UINib *ax_Nib(NSString *name);

/**
 创建xib

 @param aClass 必须 xib 同名称
 @return UINib
 */
UINib *ax_NibClass(Class _Nonnull aClass);

/**
 UIImage With 图片名

 @param name 图片名
 @return UIImage
 */
UIImage *ax_Image(NSString *name);

#pragma mark - 添加属性

/**
 Retain Strong nonatomic 属性添加值

 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setStrongAssociatedObject(id object, const void *propertyName,
                                  id value);

/**
 Copy nonatomic 属性添加值

 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setCopyAssociatedObject(id object, const void *propertyName, id value);

/**
 Retain Strong nonatomic 属性添加值

 @param object 对象
 @param propertyName 属性名 @selector() 格式
 @param value 值
 */
void ax_setAssignAssociatedObject(id object, const void *propertyName,
                                  id value);

/**
 Retain Strong Copy Assign 对象获取值
 Assign 需要转型

 @param object 实例
 @param propertyName 属性名 @selector() 格式
 @return id 值
 */
id ax_getAssociatedObject(id object, const void *propertyName);

/**
 gcd 创建串行队列 queue

 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_SERIAL(const char *label);

/**
 gcd 创建并行队列 queue

 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_CONCURRENT(const char *label);

/**
 * Localizable.strings  标准名称 国际化文件
 */
NSString *AXNSLocalizedString(NSString *key);

/**
 * AXKit 自定义国际化文件
 */
NSString *AXKitLocalizedString(NSString *key);

/**
 * 当前活动窗口的控制器
 */
UIViewController *ax_currentViewController(void);

/**
 * app代理
 */
id<UIApplicationDelegate> ax_mainAppDelegate(void);

/**
 * app根控制器
 */
UIViewController *ax_rootViewController(void);

/**
 * AppDelegate app根控制器 个别情况下 AXRootViewController 取值不对
 */
UIViewController *ax_rootViewController_appDelegate(void);

/**
 keyWindow
 */
UIWindow *ax_keyWindow(void);

/**
 封装NSLog用printf 没有__FILE__ 和 __FILE__

 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXLoger(NSString *format, ...);


/**
  封装NSLog用printf 有__FILE__ 和 __FILE__

 @param file __FILE__
 @param function __FUNCTION__
 @param line __LINE__
 @param format format
 @param ... NSLog样式 ...
 */
void AXLogerInfo(const char *file, const char *function, NSUInteger line,
                 NSString *format, ...);

void AXLogerMessage(NSString *msg,NSString *format, ...);

/**
 封装NSLog用printf 纯输出
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXNoMsgLog(NSString *format, ...);

/**
 打开iPhone设置界面
 */
void AXOpenSettings(void);

/**键盘背景色透明 alpha=0 */
void ax_keyboard_bg_alpha_zero(void);

/**键盘背景色透明*/
void ax_keyboard_bg_alpha(CGFloat alpha);

/**键盘背景UIInputSetHostView*/
UIView *ax_keyboard_host_view(void);

NS_ASSUME_NONNULL_END
