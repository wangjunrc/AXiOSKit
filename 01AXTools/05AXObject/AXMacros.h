//
//  AXMacros.h
//  AXiOSTools
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXMacros_runTime.h"
#import "AXMacros_log.h"
#import "AXMacros_instance.h"


#define AX_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define AX_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/**
 * 弱引用
 */
#define axSelfWeak __weak typeof(self) selfWeak = self;

/**
 * ax_kWeakObj(block 外面使用)
 */
#define axWeakObj(obj) __weak typeof(obj) obj##Weak = obj;

/**
 * StrongObj(block 里面使用)
 */
#define axStrongObj(obj) __strong typeof(obj) obj = obj##Weak;

/**
 * app代理
 */
#define axMainAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

/**
 * app根控制器
 */
#define axRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

/**
 * 当前活动窗口的控制器
 */
#define axCurrentViewController [UIViewController ax_currentViewController]


/**
 *  屏幕宽
 */
#define axScreenWidth [UIScreen mainScreen].bounds.size.width

/**
 * 屏幕高
 */
#define axScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 * NSNotificationCenter
 */
#define axNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * NSUserDefaults
 */
#define axUserDefaults [NSUserDefaults standardUserDefaults]

/**
 * NSUserDefaults synchronize
 */
#define axUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]


#define axTableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

/**
 * 消除 过期警告 top
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

/**
 * 消除 过期警告 botton
 */
#pragma clang diagnostic pop

/**
 * vc中定义一个同名的view替代原来的 aViewClass 需要替代的view
 */
#define AX_REDEFINE_CONTROLLER_VIEW_IMPL(aViewClass)\
@dynamic view;\
- (void)loadView{\
[super loadView];\
self.view = [[aViewClass alloc]init];\
}\
- (void)setView:(aViewClass *)view{\
[super setView:view];\
}\
- (aViewClass *)view{\
return (aViewClass *)[super view];\
}\
