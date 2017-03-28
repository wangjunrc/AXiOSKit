//
//  UIButton+AXCountDown.m
//  BigApple
//
//  Created by Mole Developer on 2017/3/27.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIButton+AXCountDown.h"

@interface UIButton ()
/**
 * 记录初始化时间
 */
@property (nonatomic, assign) NSInteger secondsCount;

@end

@implementation UIButton (AXCountDown)

/** 记录总共的时间 */
static NSInteger showTime;

/**
 短信倒计时事件,不需要主动调用开始
 
 @param second 时长
 @param condition 条件
 @param events 事件
 */
- (void)ax_messageWithSecond:(NSInteger)second condition:(BOOL (^)())condition events:(void(^)(UIButton *button))events{
    
    self.secondsCount = second;
    
    if (showTime>0) {
        [self ax_beginCountDown];
    }else{
        showTime = second;
    }
    
    [self ax_addTargetBlock:^(UIButton *button) {
        
        [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
        if (condition==nil) {
            events(self);
            [self ax_beginCountDown];
        }else{
            BOOL success = condition();
            if(success==YES){
                events(self);
                [self ax_beginCountDown];
            }
        }
    }];
    
}


-(void)ax_beginCountDown{
    [self loopEvents];
}

-(void)ax_stopCountDown{
    self.enabled = YES;
    showTime =  self.secondsCount;
}

-(void)loopEvents{
    
    if (showTime<=0) {
        return;
    }
    
    self.enabled = NO;
    NSString *text = [NSString stringWithFormat:@"%lds后重新获取",(long)  showTime];
    self.titleLabel.text = text;//防止闪烁
    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [self setTitle:text forState:UIControlStateDisabled];
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        showTime--;
        if (showTime <= 0) {
            [timer invalidate];
            self.enabled = YES;
            showTime = self.secondsCount;
            return;
        }
        
        NSString *text = [NSString stringWithFormat:@"%lds后重新获取",(long) showTime];
        self.titleLabel.text = text;
        [self setTitle:text forState:UIControlStateDisabled];
    }];
}

-(void)setSecondsCount:(NSInteger)secondsCount{
    objc_setAssociatedObject(self, @selector(secondsCount),@(secondsCount), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)secondsCount{
    return [objc_getAssociatedObject(self,@selector(secondsCount))integerValue];
}

@end
