//
//  NSObject+AXAssistant.h
//  AXiOSKit
//
//  Created by axing on 2019/7/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 是debug 环境下
 
 @return 是否
 */
FOUNDATION_EXPORT BOOL ax_isDebug(void);

/**
 是否 iPad
 @return 是否
 */
FOUNDATION_EXPORT BOOL ax_isiPad(void);

/**
 * AppStore链接,填写自己的iD
 */
FOUNDATION_EXPORT NSString *ax_AppStoreURL(NSString *appId);

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
FOUNDATION_EXPORT NSString *ax_AppStoreScoreURL(NSString *AppStoreID);

/**
 拨打电话,直接拨打
 
 @param phone 号码
 
 @return 是否成功
 */
FOUNDATION_EXPORT BOOL ax_CallTel(NSString *phone);

/**
 * 打开通用设置
 */
FOUNDATION_EXPORT BOOL ax_OpenPrefsRoot(void);

/**
 是否能打开url
 
 @param url url str
 
 @return 是否打开
 */
FOUNDATION_EXPORT BOOL ax_CanOpenURL(id url);

/**
 打开url
 
 @param url url str
 
 @return 打开是否成功
 */
FOUNDATION_EXPORT BOOL ax_OpenURLStr(id _Nonnull url);

/**
 打开URL NSString || NSURL
 
 @param url NSString || NSURL
 @return BOOL
 */
FOUNDATION_EXPORT BOOL ax_OpenURL(id _Nonnull url);

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
FOUNDATION_EXPORT BOOL ax_CallTelprompt(NSString *phone);

/**
 * URL With str
 */
FOUNDATION_EXPORT NSURL *ax_URLWithStr(NSString *str);

/**
 * int --> NSString
 */
FOUNDATION_EXPORT NSString *ax_intToString(int aInt);

/**
 * double --> NSString
 */
FOUNDATION_EXPORT NSString *ax_doubleToString(double aDouble);

/**
 * double --> NSString
 */
FOUNDATION_EXPORT NSString *ax_floatToString(float aFloat);

/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
FOUNDATION_EXPORT int ax_randomZeroToValue(int to);

/**
 * 获取一个随机整数，范围在[from,t]，包括from，包括to
 */
FOUNDATION_EXPORT int ax_randomFromTo(int from, int to);

/**
 gcd 创建串行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
FOUNDATION_EXPORT dispatch_queue_t ax_get_queue_SERIAL(const char *label);

/**
 gcd 创建并行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
FOUNDATION_EXPORT dispatch_queue_t ax_get_queue_CONCURRENT(const char *label);

/**
 * Localizable.strings  标准名称 国际化文件
 */
FOUNDATION_EXPORT NSString *AXNSLocalizedString(NSString *key);

/**
 * AXKit 自定义国际化文件
 */
FOUNDATION_EXPORT NSString *AXKitLocalizedString(NSString *key);



/**
 打开iPhone设置界面
 */
FOUNDATION_EXPORT void AXOpenSettings(void);
