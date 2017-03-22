//
//  AXConstant.h
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/1.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ax_cellID;

extern NSString *const ax_headID;

extern NSString *const ax_footID;

extern NSString *const ax_UserInfoSaveDict;

extern NSString *const ax_estimatedProgress;

extern NSString *const ax_title;


typedef void(^AXNoParamasBlock)();
typedef void(^AXBackBlock)(id string);
typedef void(^AXBackBlockDict)(NSDictionary *dict);

@interface AXConstant : NSObject
/**
 是否能打开url
 
 @param str url str
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(NSString  *str);

/**
 打开url
 
 @param str url str
 
 @return 打开是否成功
 */
BOOL ax_OpenURL(NSString  *str);

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString  *phone);

/**
 拨打电话,直接拨打
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString  *phone);

/**
 xcode 奔溃日志
 */
void ax_LogXcodeCache();


UINib * ax_Nib(NSString  *name);
/**
 * AppStore链接,填写自己的iD
 */
NSString * ax_AppStoreURL(NSString  *appId);

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
int ax_getRandomZeroToValue(int to);
/**
 * 获取一个随机整数，范围在[from,t]，包括from，包括to
 */
int ax_getRandomFromTo(int from ,int to);


@end




