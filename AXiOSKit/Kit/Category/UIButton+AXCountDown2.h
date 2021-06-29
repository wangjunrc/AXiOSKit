//
//  UIButton+AXCountDown.h
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/8/17.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AXCountDown2)


/**
 @param duration 倒计时时间
 @param action 按钮点击事件的回调
 @param start 倒计时开始时的回调
 @param progress 倒计时进行中的回调（每秒一次）
 @param completion 倒计时完成时的回调
 */
- (void)ax_countDownWithDuration:(NSInteger)duration
                          action:(void(^)(void))action
                           start:(void(^)(void))start
                        progress:(void(^)(NSInteger second))progress
                      completion:(void(^)(void))completion;

/** 开始倒计时 */
- (void)ax_startCountDown;

/** 结束倒计时 */
- (void)ax_endCountDown;

@end
