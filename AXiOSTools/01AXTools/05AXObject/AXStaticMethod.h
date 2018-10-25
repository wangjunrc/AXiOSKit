//
//  AXStaticMethod.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AXStaticMethod : NSObject


#pragma mark - Foundation

/**
 xcode 奔溃日志
 */
void ax_LogXcodeCache(void);

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
NSString * _Nullable ax_AppStoreURL(NSString * _Nullable appId);

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
NSString * _Nullable ax_AppStoreScoreURL(NSString * _Nonnull AppStoreID);

/**
 拨打电话,直接拨打
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString * _Nonnull phone);

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot(void);

/**
 是否能打开url
 
 @param url url str
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(id _Nonnull url);

/**
 打开url
 
 @param url url str
 
 @return 打开是否成功
 */
BOOL ax_OpenURLStr(id  _Nonnull url);

/**
 打开URL NSString || NSURL
 
 @param url NSString || NSURL
 @return BOOL
 */
BOOL ax_OpenURL(id  _Nonnull url);

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString * _Nonnull phone);

/**
 * URL With str
 */
NSURL * _Nonnull ax_URLWithStr(NSString * _Nonnull str);

/**
 * int --> NSString
 */
NSString * _Nonnull ax_intToString(int aInt);

/**
 * double --> NSString
 */
NSString * _Nonnull ax_doubleToString(double aDouble);

/**
 * double --> NSString
 */
NSString * _Nonnull ax_floatToString(float aFloat);

/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_getRandomZeroToValue(int to);

/**
 * 获取一个随机整数，范围在[from,t]，包括from，包括to
 */
int ax_getRandomFromTo(int from ,int to);


#pragma mark - UIKit

/**
 创建xib With xib 名称
 
 @param name xib 名称
 @return UINib
 */
UINib * _Nonnull ax_Nib(NSString * _Nonnull name);

/**
 创建xib
 
 @param aClass xib 名称 xib与源文件名称一致
 @return UINib
 */
UINib * _Nonnull ax_NibClass(Class  _Nonnull aClass);

/**
 UIImage With 图片名
 
 @param name 图片名
 @return UIImage
 */
UIImage * _Nonnull ax_Image(NSString * _Nonnull name);



#pragma mark - 添加属性

/**
 Retain Strong nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名
 @param value 值
 */
void ax_setStrongAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id _Nonnull value );


/**
 Copy nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名
 @param value 值
 */
void ax_setCopyAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id _Nonnull value );
/**
 Retain Strong nonatomic 属性添加值
 
 @param object 对象
 @param propertyName 属性名
 @param value 值
 */
void ax_setAssignAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName ,id _Nonnull value );

/**
 Retain Strong Copy Assign 对象获取值
 Assign 需要转型
 
 @param object 实例
 @param propertyName 属性名
 @return id 值
 */
id _Nullable ax_getAssociatedObject(id _Nonnull object, const void * _Nonnull propertyName);



/**
 gcd 创建串行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t _Nullable ax_get_queue_SERIAL(const char *_Nullable label);

/**
 gcd 创建并行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t _Nullable ax_get_queue_CONCURRENT(const char *_Nullable label);


@end
