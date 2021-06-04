//
//  AlertWayClass.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/6/4.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AlertWayClass.h"


@interface AlertWayClass()
//停止标志
@property (nonatomic,assign,readwrite) BOOL stop;
//声音ID
@property (nonatomic,assign,readwrite) SystemSoundID crash;
@end

@implementation AlertWayClass
+ (AlertWayClass *)sharedInstance
{
    static AlertWayClass *alertWay;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        alertWay = [[AlertWayClass alloc] init];
    });
    return alertWay;
}

- (instancetype)init
{
    if (self = [super init]) {
        SystemSoundID crash;
        NSURL* crashUrl = [[NSBundle mainBundle]
                           URLForResource:@"high_alarm" withExtension:@"mp3"];
        // 加载音效文件
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashUrl , &crash);
        // 为crash播放完成绑定回调函数
        AudioServicesAddSystemSoundCompletion(crash, NULL, NULL,
                                              (void*)completionCallback ,NULL);
        // 为震动完成绑定回调函数
        AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,
                                              (void*)completionVibrateCallback ,NULL);
        
        self.crash = crash;
        self.stop = NO;
    }
    return self;
}
//振动完成的回调（继续振动）
static void completionVibrateCallback(SystemSoundID mySSID)
{
    if ([AlertWayClass sharedInstance].stop) {
        return;
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
//音频播放完成的回调（继续播放）
static void completionCallback(SystemSoundID mySSID)
{
    // 播放完毕之后，再次播放
    if ([AlertWayClass sharedInstance].stop) {
        return;
    }
    //响铃
    //AudioServicesPlaySystemSound([AlertWayClass sharedInstance].crash);
    //响铃加振动
    AudioServicesPlayAlertSound([AlertWayClass sharedInstance].crash);
}

-(void)playAlertID:(SystemSoundID )crash{
    self.crash = crash;
    self.stop = NO;
    //响铃
    //AudioServicesPlaySystemSound(self.crash);
    //振动
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //响铃加振动
    AudioServicesPlayAlertSound(self.crash);
    [NSTimer scheduledTimerWithTimeInterval:20 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [[AlertWayClass sharedInstance] stopAlert];
    }];
}
-(void)stopAlert{
    self.stop = YES;
}
@end

