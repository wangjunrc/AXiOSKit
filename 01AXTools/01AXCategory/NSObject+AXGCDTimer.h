//
//  NSObject+AXGCDTimer.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AXGCDTimer)

/**
 GCD timer 不会强引用 ,不自动开始,调用 Resume
 必须全局属性一下
 
 @property(nonatomic,strong)dispatch_source_t timer2;
 用 strong 不要用 assign
 @param aInterval 间隔
 @param block 回调
 @return 对象
 */
-(dispatch_source_t )ax_gcdLoopTimer:(NSTimeInterval)aInterval block:(void(^)(void))block;


/**
 GCD timer 开始
 
 @param gcdTimer dispatch_source_t
 */
-(void)ax_gcdLoopTimerResume:(dispatch_source_t )gcdTimer;


/**
 GCD timer 取消
 
 @param gcdTimer dispatch_source_t
 */
-(void)ax_gcdLoopTimerCancel:(dispatch_source_t )gcdTimer;


@end
