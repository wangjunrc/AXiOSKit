//
//  AXMacros.h
//  ZBP2P
//
//  Created by Mole Developer on 2017/1/3.
//  Copyright © 2017年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>
//xcode8 log

#ifdef DEBUG
#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
#define AXLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define AXLog(...)
#endif

#ifdef DEBUG
#define AXLog2(...) printf("%s\n\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define AXLog2(...)
#endif

#ifdef DEBUG
#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
#define MyLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define MyLog(...)
#endif


#define  AXLogFunc AXLog(@"%s",__func__);

#define ax_kMainColor [UIColor ax_colorRed:58 green:164 blue:249]

#define ax_kLong_Dealloc  AXLog(@"dealloc %@",self.class)

// 弱引用
#define axSelfWeak __weak typeof(self) selfWeak = self;

/**
 * ax_kWeakObj(block 外面使用)
 */
#define axWeakObj(obj) __weak typeof(obj) obj##Weak = obj;
/**
 * StrongObj(block 里面使用)
 */
#define axStrongObj(obj) __strong typeof(obj) obj = obj##Weak;


#define axLong_Dealloc AXLog(@"dealloc %@",self.class)

/**
 * 单例模式,  .h文件
 */
#define axShared_H(name)  +(instancetype )shared##name;

/**
 * 单例模式,  .m文件
 */
#define  axShared_M(name)\
static id _instance; \
static dispatch_once_t _onceToken; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
dispatch_once(&_onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone { \
return _instance; \
}
/*===单例模式,.m文件 end ===*/


/**
 * 友盟推送
 */
#define Key_UM_Push @"572c20dce0f55ad0af000f85"

/**
 * 高德地图
 */
#define Key_GaoDe_Map @"8d30333c2322696ad50becf3d554a8f0"

/**
 * 融云聊天 key
 */
#define Key_RCIM @"e5t4ouvptpf5a" //生产key
/**
 * AppStoreID
 */
#define HAppStoreID @"1066134689"


#define MainBGColor  [UIColor ax_colorFrom16RGB:0x1DB56C]

#define kColorBarBackground [UIColor colorWithRed:104.0f/255.0f green:194.0f/255.0f blue:110.0f/255.0f alpha:1]

#define kColorSepLindBackground [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1]

#define kTop 20

#define kMargin 10


/**
 * 默认头像
 */
#define axHeadImage  [UIImage imageNamed:@"default_head"]


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
 * NSNotificationCenter
 */
#define axNotificationCenter [NSNotificationCenter defaultCenter]


/**
 *  屏幕宽
 */
#define axScreenWidth [UIScreen mainScreen].bounds.size.width

/**
 * 屏幕高
 */
#define axScreenHeight [UIScreen mainScreen].bounds.size.height


#define axTableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];


/**
 * NSUserDefaults
 */
#define axUserDefaults [NSUserDefaults standardUserDefaults]
/**
 * NSUserDefaults synchronize
 */
#define axUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]


/**
 * 默认头像
 */
#define HHeadImage  [UIImage imageNamed:@"tx_default"]

/**
 * AppStoreID
 */
#define H_AppStoreID @"997625918"
