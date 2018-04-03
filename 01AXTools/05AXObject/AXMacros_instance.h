//
//  AXMacros_instance.h
//  BigApple
//
//  Created by Mole Developer on 2017/6/28.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#ifndef AXMacros_instance_h
#define AXMacros_instance_h

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




#endif /* AXMacros_instance_h */
