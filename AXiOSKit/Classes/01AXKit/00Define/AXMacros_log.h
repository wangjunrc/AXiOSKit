//
//  AXMacros_log.h
//  BigApple
//
//  Created by liuweixing on 2017/6/28.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#ifndef AXMacros_log_h
#define AXMacros_log_h
#import "NSDate+AXKit.h"
#import "AXFoundationAssistant.h"

/**
 FILEString 文件名
 
 */
//#ifdef DEBUG
//#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
//#define AXLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSSSSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#else
//#define AXLog(...)
//#endif

#ifdef DEBUG
#define AXLog(...) AXLogerInfo(__FILE__,__FUNCTION__,__LINE__,##__VA_ARGS__);
#else
#define AXLog(...)
#endif



//#ifdef DEBUG
//#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
//#define AXLog(...) NSLog(@"[%s 第%d行]: %s\n\n", FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#else
//#define AXLog(...)
//#endif


#define AXLogFunc AXLog(@"%s",__func__);
#define axLong_viewDidLoad AXLog(@"viewDidLoad>> %@",self.class);
#define axLong_dealloc AXLog(@"dealloc>> %@",self.class);

#endif /* AXMacros_log_h */
