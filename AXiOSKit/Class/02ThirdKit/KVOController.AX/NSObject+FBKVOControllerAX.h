//
//  NSObject+FBKVOControllerAX.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/4/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

/// 使用 FBKVO path 宏
/**
 For example: 可以提示
 AX_FBKVOKeyPath(self.dataArray)
 
 */
#define AX_FBKVOKeyPath(KEYPATH) \
@(((void)(NO && ((void)KEYPATH, NO)), \
({ const char *fbkvokeypath = strchr(#KEYPATH, '.'); NSCAssert(fbkvokeypath, @"Provided key path is invalid."); fbkvokeypath + 1; })))

/**
 
 For example: 不会提示

 AX_FBKVOClassKeyPath(ViewController,dataArray)
 
 */
#define AX_FBKVOClassKeyPath(CLASS, KEYPATH) \
@(((void)(NO && ((void)((CLASS *)(nil)).KEYPATH, NO)), #KEYPATH))


#import <Foundation/Foundation.h>

/**
 FBKVOControllerAX 返回对象
 */
@interface AXKVOResultModel : NSObject

/**监听对象*/
@property (nullable, nonatomic, strong)id observer;

/**监听对象*/
@property (nullable, nonatomic, strong)id object;

/**路径*/
@property (nullable, nonatomic, copy)NSString *keyPath;

/**旧值*/
@property (nullable, nonatomic, strong)id oldValue;

/**新的值*/
@property (nullable, nonatomic, strong )id aNewValue;

@end


@interface NSObject (FBKVOControllerAX)

/**
 Facebook kvo
 封装 因为强引用 分别用
KVOControllerNonRetaining(目前使用) 和 KVOController(不知道具体区别)
 
 
 NSMutableArray 添加用
 [[self mutableArrayValueForKey:@""]addObject:];
 
 set 用
 mutableSetValueForKey
 
 NSMutableDictionary 添加用
 [self willChangeValueForKey:@"dict"];
 self.dict[@""] = @"";
 [self didChangeValueForKey:@"dict"];
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath
                     block:(void(^_Nullable)(NSString * _Nullable keyPath,id _Nullable oldValue ,id _Nullable newValue ))block;

/**
 Facebook kvo 封装
 KVOControllerNonRetaining 
 @param keyPath 路径
 @param result 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath
                    result:(void(^_Nullable)(AXKVOResultModel * _Nonnull resultModel))result;

@end
