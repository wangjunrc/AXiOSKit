//
//  NSObject+FBKVOControllerAX.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

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
 
 @param keyPath 路径
 @param result 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath
                    result:(void(^_Nullable)(AXKVOResultModel * _Nonnull resultModel))result;

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_KVOControllerKeyPath:(nullable NSString *)keyPath block:(void(^_Nullable)(NSString * _Nonnull  pathKey, id _Nullable  oldValue , id _Nullable newValue ))block DEPRECATED_MSG_ATTRIBUTE("请使用: - (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath block:(void(^_Nullable)(NSString * _Nullable keyPath,id _Nullable oldValue ,id _Nullable newValue ))block");

@end
