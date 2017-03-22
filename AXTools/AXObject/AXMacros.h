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


//#ifdef DEBUG
//#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]\
//#define NowDate NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
//dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS"];\
//NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];\
//#define AXLog(...) printf("%s [%s 第%d行]: %s\n\n",[dateStr UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#else
//#define AXLog(...)
//#endif

//#ifdef DEBUG
//#define AXLog(format, ...) printf("\n[%s] [第%d行] %s\n", __TIME__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define AXLog(format, ...)
//#endif

#define ax_kMainColor [UIColor ax_colorRed:58 green:164 blue:249]

#define ax_kLong_Dealloc  AXLog(@"dealloc %@",self.class)

// 弱引用
#define ax_kSelfWeak __weak typeof(self) selfWeak = self;
/**
 * ax_kWeakObj(block 外面使用)
 */
#define ax_kWeakObj(obj) __weak typeof(obj) obj##Weak = obj;
/**
 * StrongObj(block 里面使用)
 */
#define ax_kStrongObj(obj) __strong typeof(obj) obj = obj##Weak;


//#define  ax_kRegisterNib(nib,ID) registerNib:[UINib nibWithNibName:nib bundle:nil] forCellWithReuseIdentifier:ID

#define ax_kNib(name)  [UINib nibWithNibName:name bundle:nil]
/**
 * 单例模式,  .h文件
 */
#define ax_kShared_H(name)  +(instancetype )shared##name;

/**
 * 单例模式,  .m文件
 */
#define  ax_kShared_M(name)\
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
#define H_AppStoreID @"997625918"


#define MainBGColor  [UIColor ax_colorFrom16RGB:0x1DB56C]

#define kColorBarBackground [UIColor colorWithRed:104.0f/255.0f green:194.0f/255.0f blue:110.0f/255.0f alpha:1]

#define kColorSepLindBackground [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1]

#define kTop 20

#define kMargin 10


/**
 * 默认头像
 */
#define ax_kHeadImage  [UIImage imageNamed:@"default_head"]


/**
 * app代理
 */
#define ax_kMainAppDelegate	 ((AppDelegate*)([UIApplication sharedApplication].delegate))

/**
 * app根控制器
 */
#define ax_kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

/**
 * 当前活动窗口的控制器
 */
#define ax_kCurrentViewController [UIViewController ax_currentViewController]

/**
 * NSNotificationCenter
 */
#define ax_kNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * NSUserDefaults
 */
#define ax_kUserDefaults [NSUserDefaults standardUserDefaults]
/**
 * NSUserDefaults synchronize
 */
#define ax_kUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

/**
 *  UIScreen width
 */
#define ax_kScreenWidth [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height
 */
#define ax_kScreenHeight [UIScreen mainScreen].bounds.size.height

#define ax_TableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];


