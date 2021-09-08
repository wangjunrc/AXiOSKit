//
//  AXMacros_instance.h
//  BigApple
//
//  Created by liuweixing on 2017/6/28.
//  Copyright © 2017年 liuweixing. All rights reserved.
//


#ifndef AXMacros_instance_h
#define AXMacros_instance_h

// 置nil .h

#define axSharedCancel_H  +(void )sharedCancel;

// 置nil .m
#define  axSharedCancel_M \
+ (void)sharedCancel \
{\
_instance = nil;\
_onceToken = 0l;\
};\
/*===单例模式,.m文件 end ===*/


/// 单例模式 定义
#define AX_SINGLETON_INTER(name)  + (instancetype )shared##name;

/// 单例模式 实现
#define  AX_SINGLETON_IMPL(name)\
static id _instance; \
static dispatch_once_t _onceToken; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
dispatch_once(&_onceToken, ^{\
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name{\
return [[self alloc]init];\
}\
\
- (id)copyWithZone:(NSZone *)zone {\
    return _instance; \
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance;\
}\


/// 单例 取消单例 .m文件
#define AX_CANCEL_SINGLETON_INTER +(void)cancelSingleton;

/// 单例 取消单例 .m文件
#define AX_CANCEL_SINGLETON_IMPL \
+(void)cancelSingleton {\
    _instance = nil;\
_onceToken=0;\
}\

#endif /* AXMacros_instance_h */

