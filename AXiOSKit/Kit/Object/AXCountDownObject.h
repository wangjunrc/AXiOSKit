//
//  AXCountDownObject.h
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/8/17.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSWeakTimer.h"



@interface AXCountDownObject : NSObject

@property (nonatomic, assign) NSInteger startCountDownNum;
@property (nonatomic, assign) NSInteger restCountDownNum;

/** 控制倒计时的timer */
@property (nonatomic, strong) MSWeakTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) void(^actionBlock)(void);
/** 倒计时开始时的回调 */
@property (nonatomic, copy) void(^startBlock)(void);
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) void(^progressBlock)(NSInteger second);
/** 倒计时完成时的回调 */
@property (nonatomic, copy) void(^completionBlock)(void);

@end
