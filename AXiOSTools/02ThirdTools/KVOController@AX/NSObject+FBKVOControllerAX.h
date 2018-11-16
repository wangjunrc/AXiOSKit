//
//  NSObject+FBKVOControllerAX.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath block:(void(^_Nullable)(NSString * _Nullable keyPath,id _Nullable oldValue ,id _Nullable newValue ))block;

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_KVOControllerKeyPath:(nullable NSString *)keyPath block:(void(^_Nullable)(NSString * _Nonnull  pathKey, id _Nullable  oldValue , id _Nullable newValue ))block DEPRECATED_MSG_ATTRIBUTE("请使用: - (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath block:(void(^_Nullable)(NSString * _Nullable keyPath,id _Nullable oldValue ,id _Nullable newValue ))block");

@end
