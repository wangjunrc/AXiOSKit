//
//  AXRecordAudioService.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/12.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXRecordAudioConfig.h"
#import <AXiOSKit/AXiOSKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AXRecordAudioService : NSObject
AX_SINGLETON_INTER()

@property (nonatomic, strong, readonly) AXRecordAudioConfig *config;

/// config
@property (nonatomic, copy, readonly) AXRecordAudioService * (^ withConfig)(AXRecordAudioConfig *config);

/// 进度
@property (nonatomic, copy, readonly) AXRecordAudioService * (^ progress)(void (^)(NSProgress *progress));

/// 成功
@property (nonatomic, copy, readonly) AXRecordAudioService * (^ success)(void (^)(AXRecordAudioSuccess *result));

/// 失败
@property (nonatomic, copy, readonly) AXRecordAudioService * (^ failure)(void (^)(NSError *error));

/// 开始请求 start or resume recording
@property (nonatomic, copy, readonly) void (^ start)(void);

/// 结束完成
@property (nonatomic, copy, readonly) void (^ end)(void);

/// 暂停
@property (nonatomic, copy, readonly) void (^ pause)(void);

@end

NS_ASSUME_NONNULL_END
