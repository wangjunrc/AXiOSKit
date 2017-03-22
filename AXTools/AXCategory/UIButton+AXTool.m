//
//  UIButton+AXTool.m
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import "UIButton+AXTool.h"
#import <objc/runtime.h>

typedef void(^ButtonBlock)(UIButton *button);

typedef void(^TimerBlock)(UIButton *button);

@interface UIButton ()

@property(nonatomic,copy)ButtonBlock buttonBlock;

@property(nonatomic,copy)TimerBlock timerBlock;

@end


@implementation UIButton (AXTool)


-(void)ax_addTargetBlock:(void (^)(UIButton *))block{
    [self addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonBlock = block;
}
-(void)buttonEvents:(UIButton *)button{
    if (self.buttonBlock) {
        self.buttonBlock(button);
    }
}

//static char *buttonBlockID = "buttonBlockID";
/**
 * cameraBlock set方法
 */
- (void)setButtonBlock:(ButtonBlock)buttonBlock{
    objc_setAssociatedObject(self, @selector(buttonBlock),buttonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 * cameraBlock get方法
 */
- (ButtonBlock)buttonBlock{
    return objc_getAssociatedObject(self, @selector(buttonBlock));
}




/** 倒计时的显示时间 */
static NSInteger _secondsCountDown;
/** 记录总共的时间 */
static NSInteger allTime;

- (void)ax_buttonWithTime:(CGFloat)countDownTime {
    self.enabled = NO;
    _secondsCountDown = countDownTime;
    allTime = countDownTime;
    [self setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)_secondsCountDown] forState:UIControlStateDisabled];
    
     NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}
-(void)timeFireMethod:(NSTimer *)countDownTimer{
    //倒计时-1
    _secondsCountDown--;
    //修改倒计时标签现实内容
    [self setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)_secondsCountDown] forState:UIControlStateDisabled];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown == 0){
        [countDownTimer invalidate];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        _secondsCountDown = allTime;
        self.enabled = YES;
    }
}


- (void)setTimerBlock:(TimerBlock)timerBlock{
    objc_setAssociatedObject(self, @selector(timerBlock),timerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TimerBlock)timerBlock{
    return objc_getAssociatedObject(self, @selector(timerBlock));
}

/**
 * 循环时间 事件,初始化时调用
 */
- (void)ax_buttonEventsWithTime:(CGFloat)countDownTime block:(void(^)(UIButton *button))block {
    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    self.timerBlock = block;
    
    self.enabled = YES;
    if (_secondsCountDown>0) {
        [self touchUpInsideEvents:self];
        _secondsCountDown = _secondsCountDown;
        allTime = _secondsCountDown;
    }else{
        _secondsCountDown = countDownTime;
        allTime = countDownTime;
    }
    
//    [self addTarget:self action:@selector(touchUpInsideEvents:) forControlEvents:UIControlEventTouchUpInside];
   [self touchUpInsideEvents:self];
}

-(void)touchUpInsideEvents:(UIButton *)button{

    if (self.timerBlock) {
        self.enabled = NO;
        NSString *text = [NSString stringWithFormat:@"%lds后重新获取",(long)_secondsCountDown];
        [self setTitle:text forState:UIControlStateDisabled];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(buttonCycleTimer:) userInfo:self repeats:YES];
         [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        self.timerBlock(button);
    }

}

//定时器事件
-(void)buttonCycleTimer:(NSTimer *)timer{
    _secondsCountDown--;
    NSString *text = [NSString stringWithFormat:@"%lds后重新获取",(long)_secondsCountDown];
    [self setTitle:text forState:UIControlStateDisabled];
    if (_secondsCountDown <= 0) {
        [timer invalidate];
        self.enabled = YES;
        return;
    }
}


@end
