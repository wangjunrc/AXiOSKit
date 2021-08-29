//
//  NSObject+AXLoger.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/18.
//

#import <Foundation/Foundation.h>

/**
 封装NSLog用printf 没有__FILE__ 和 __FILE__
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
FOUNDATION_EXPORT void AXLoger(NSString *format, ...);

/**
 封装NSLog用printf 有__FILE__ 和 __FILE__
 
 @param file __FILE__
 @param function __FUNCTION__
 @param line __LINE__
 @param format format
 @param ... NSLog样式 ...
 */
FOUNDATION_EXPORT void AXLogerInfo(const char *file, const char *function, NSUInteger line,
                                   NSString *format, ...);

/**
 封装NSLog用printf,添加打印头部标识 没有__FILE__ 和 __FILE__
 
 @param msg 标识
 @param format 样式
 @param ... 参数
 */
FOUNDATION_EXPORT void AXLogerMessage(NSString *msg,NSString *format, ...);

/**
 封装NSLog用printf 纯输出
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
FOUNDATION_EXPORT void AXNoMsgLog(NSString *format, ...);


#ifdef DEBUG
#define AXLog(...) AXLogerInfo(__FILE__,__FUNCTION__,__LINE__,##__VA_ARGS__);
#else
#define AXLog(...)
#endif

//#ifdef DEBUG
//#define NSLog(...) AXLogerInfo(__FILE__,__FUNCTION__,__LINE__,##__VA_ARGS__);
//#else
//#define NSLog(...)
//#endif


#define AXLogFunc AXLog(@"%s",__func__);
#define axLong_viewDidLoad AXLog(@"viewDidLoad>> %@",self.class);
#define axLong_dealloc AXLog(@"dealloc>> %@",self.class);

