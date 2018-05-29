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

/**
 self.tableView.tableFooterView
 */
#define axTableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];


/**
 view 中 加载xib自定义view
 */
#define ax_load_xib_view \
self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].lastObject;\
self.frame = frame;\

/**
 showHUD
 */
#define AX_showHUD_Message(String)  MBProgressHUD *hud = [MBProgressHUD ax_showMessage:String];
/**
 hideHUD 
 */
#define AX_hideHUD  [hud hideAnimated:YES];


/**
 tableViewCell 自适应高度DataSource
 */
#define AX_tableViewCell_height_Automatic \
-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{\
    return UITableViewAutomaticDimension;\
}\
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{\
    return UITableViewAutomaticDimension;\
}\


/**
 * 让代码奔溃
 */
// NSAssert(0, @"必须有sourceView或者item");

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





