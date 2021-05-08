//
//  AXUserInfoDao.h
//  macOS_demo
//
//  Created by 小星星吃KFC on 2020/10/15.
//

#import <Foundation/Foundation.h>
#import "DBFunctionProtocol.h"
#import "AXUserInfo.h"

/**
 * 单例模式,  .h文件 DL_SINGLETON_INTER
 */
#define axShared_H(name)  + (instancetype )shared##name;

/**
 * 单例模式,  .m文件 DL_SINGLETON_IMPL
 */
#define  axShared_M(name)\
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

NS_ASSUME_NONNULL_BEGIN

@interface AXUserInfoDao : NSObject<DBFunctionProtocol>

axShared_H(Dao);

@end

NS_ASSUME_NONNULL_END
