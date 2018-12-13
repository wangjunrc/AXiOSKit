//
//  UIButton+AXCountDown.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIButton+AXCountDown2.h"
#import "AXCountDownObject.h"
#import "AXMacros_addProperty.h"

@interface UIButton ()

@property(nonatomic, strong)AXCountDownObject *downObject;

@end

@implementation UIButton (AXCountDown2)



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
                      completion:(void(^)(void))completion {
    
    [self setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    self.downObject.startCountDownNum = duration;
    self.downObject.actionBlock = action;
    self.downObject.startBlock      = start;
    self.downObject.progressBlock = progress;
    self.downObject.completionBlock = completion;
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}


/** 按钮点击 */
- (void)buttonClicked:(UIButton *)sender {
    
    self.downObject.actionBlock();
    
}

/** 开始倒计时 */
- (void)ax_startCountDown {
    
    
    if (self.downObject.timer) {
        [self.downObject.timer invalidate];
        self.downObject.timer = nil;
    }
    self.downObject.restCountDownNum = self.downObject.startCountDownNum+1;
    
    self.enabled = NO;
    
    
    self.downObject.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshButton) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
    
    [self.downObject.timer fire];
    
}

/** 刷新按钮内容 */
- (void)refreshButton {
    
    self.downObject.restCountDownNum --;
    
    // 调用倒计时进行中的回调
    if (self.downObject.progressBlock) {
        self.downObject.progressBlock(self.downObject.restCountDownNum);
    }
    
    
    if (self.downObject.restCountDownNum == 0) {
        
        [self ax_endCountDown];
        
    }else{
        
        NSString *str = [NSString stringWithFormat:@"再次获取(%ld秒)", self.downObject.restCountDownNum];
        [self setTitle:str forState:UIControlStateDisabled];
    }
}

/** 结束倒计时 */
- (void)ax_endCountDown {
    
    if (self.downObject.timer) {
        [self.downObject.timer invalidate];
        self.downObject.timer = nil;
    }
    self.enabled = YES;
    !self.downObject.completionBlock ?: self.downObject.completionBlock();
}


#pragma mark - set ang get

- (void)setDownObject:(AXCountDownObject *)downObject{
    ax_setStrongPropertyAssociated(downObject);
}

- (AXCountDownObject *)downObject{
    
    id obj =  ax_getValueAssociated(downObject);
    if (nil == obj) {
        obj = [[AXCountDownObject alloc]init];
        
        self.downObject = obj;
    }
    return obj;
}

@end
