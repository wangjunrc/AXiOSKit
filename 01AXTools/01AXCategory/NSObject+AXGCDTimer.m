//
//  NSObject+AXGCDTimer.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "NSObject+AXGCDTimer.h"

@implementation NSObject (AXGCDTimer)


-(dispatch_source_t )ax_gcdLoopTimer:(NSTimeInterval)aInterval block:(void(^)(void))block{
    
    NSTimeInterval period = aInterval; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(gcdTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(gcdTimer, ^{    //在这里执行事件
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在主线程中实现需要的功能
            if (block) {
                
                block();
            }
        });
        
    });
    
    return gcdTimer;
}


-(void)ax_gcdLoopTimerResume:(dispatch_source_t )gcdTimer{
    
    dispatch_resume(gcdTimer);
}

-(void)ax_gcdLoopTimerCancel:(dispatch_source_t )gcdTimer{
    
    dispatch_source_cancel(gcdTimer); // 异步取消调度源
    gcdTimer = nil; // 将 dispatch_source_t 置为nil
}

@end
