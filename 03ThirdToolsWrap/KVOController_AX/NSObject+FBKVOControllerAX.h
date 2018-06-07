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
  Facebook kvo 封装

 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_KVOControllerKeyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(NSString * _Nullable pathKey, id _Nullable oldValue ,id _Nullable newValue ))block;



/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(NSString * _Nullable pathKey, id _Nullable oldValue ,id _Nullable newValue ))block;

@end
