//
//  AXDefineHeader.h
//  SP2P_7
//
//  Created by Mole Developer on 2016/12/1.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#ifndef AXDefineHeader_h
#define AXDefineHeader_h

//xcode8之前 log
//#ifdef DEBUG // 处于开发阶段
//#define MyLog(...) MyLog(__VA_ARGS__)
//#else // 处于发布阶段
//#define MyLog(...)
//#endif


//xcode8 log
//#ifdef DEBUG
//#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
//#define MyLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#else
//#define MyLog(...)
//#endif

//xcode8 log
#ifdef DEBUG
#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
#define MyLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define MyLog(...)
#endif

typedef void(^AXNoParameterBlock)();
#define H_Long_Dealloc MyLog(@"dealloc %@",self.class)

// 弱引用
#define H_selfWeak __weak typeof(self) selfWeak = self;
/**
 * WeakObj(block 外面使用)
 */
#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj;
/**
 * StrongObj(block 里面使用)
 */
#define StrongObj(obj) __strong typeof(obj) obj = obj##Weak;




/**
 * 单例模式,  .h文件
 */
#define H_shared_H(name)  +(instancetype )shared##name;

/**
 * 单例模式,  .m文件
 */
#define  H_shared_M(name)\
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

//MainTabC 所在ViewControllers数组中
//#define HMainTabC  self.navigationController.viewControllers[1]//新版本为1,
#define HMainTabC  self.navigationController.viewControllers[0]//旧版本为0

/**
 * 默认头像
 */
#define HHeadImage  [UIImage imageNamed:@"tx_default"]


/**
 * app代理
 */
#define MainAppDelegate	 ((AppDelegate*)([UIApplication sharedApplication].delegate))

/**
 * app根控制器
 */
#define RootViewController [UIApplication sharedApplication].keyWindow.rootViewController

/**
 * 当前活动窗口的控制器
 */
#define CurrentViewController [UIViewController ax_currentViewController]

/**
 * 能不能打开URL
 */
#define HCanURL(urlStr) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]

/**
 * 打开URL
 */
#define HOpenURL(urlStr) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]]

/**
 * NSNotificationCenter
 */
#define HNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * NSUserDefaults
 */
#define HUserDefaults [NSUserDefaults standardUserDefaults]
/**
 * NSUserDefaults synchronize
 */
#define HUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

/**
 *  UIScreen width
 */
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width


/**
 *  UIScreen width
 */
#define MainWidth    [UIScreen mainScreen].bounds.size.width


/**
 *  UIScreen height
 */
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
/**
 *  UIScreen height
 */
#define MainHeight   [UIScreen mainScreen].bounds.size.height

/**
 * AppStore链接,填写自己的iD
 */
#define OpenAppStoreURL @"https://itunes.apple.com/cn/app/id1064841981?mt=8"



#define   H_tableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

#endif /* AXDefineHeader_h */
