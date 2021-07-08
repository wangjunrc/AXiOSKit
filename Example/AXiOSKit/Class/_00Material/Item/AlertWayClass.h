//
//  AlertWayClass.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/6/4.
//  Copyright © 2021 axinger. All rights reserved.
//


#import <Foundation/Foundation.h>
//导入系统框架
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN


@interface AlertWayClass : NSObject
//停止标志
@property (nonatomic,assign,readonly) BOOL stop;
//声音ID
@property (nonatomic,assign,readonly) SystemSoundID crash;

+ (AlertWayClass *)sharedInstance;
//播放
-(void)playAlertID:(SystemSoundID )crash;
//停止
-(void)stopAlert;
@end


NS_ASSUME_NONNULL_END
