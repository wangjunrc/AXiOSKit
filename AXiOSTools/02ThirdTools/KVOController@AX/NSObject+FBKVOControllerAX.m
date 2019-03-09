//
//  NSObject+FBKVOControllerAX.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "NSObject+FBKVOControllerAX.h"

#if __has_include(<KVOController/KVOController.h>)

#import <KVOController/KVOController.h>


@implementation AXKVOResultModel

@end

@implementation NSObject (FBKVOControllerAX)

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath
                     block:(void(^_Nullable)(NSString * _Nullable keyPath,id _Nullable oldValue ,id _Nullable newValue ))block {
    // KVOControllerNonRetaining
    //KVOController
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if (block) {
            block(change[FBKVONotificationKeyPathKey],change[@"old"],change[@"new"]);
        }
    }];
    
}

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param result 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(nullable NSString *)keyPath
                    result:(void(^)(AXKVOResultModel *resultModel))result {
    // KVOControllerNonRetaining
    //KVOController
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        if (result) {
            AXKVOResultModel *model = [[AXKVOResultModel alloc]init];
            model.observer = observer;
            model.object = object;
            model.oldValue = change[@"old"];
            model.aNewValue = change[@"new"];
            model.keyPath = change[FBKVONotificationKeyPathKey];
            result(model);
        }
    }];
    
}

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_KVOControllerKeyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(NSString * _Nullable pathKey, id _Nullable oldValue ,id _Nullable newValue ))block{
    
    [self.KVOController observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if (block) {
            block(change[FBKVONotificationKeyPathKey],change[@"old"],change[@"new"]);
        }
    }];
    
}

@end

#endif
