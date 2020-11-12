//
//  AXRecordAudioConfig.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/12.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXRecordAudioConfig : NSObject

@property(nonatomic, copy) NSString *filePath;

/// 最长录音
@property(nonatomic, assign) NSTimeInterval maxDuration;

/// 最短录音
@property(nonatomic, assign) NSTimeInterval minDuration;

@end

@interface AXRecordAudioSuccess : NSObject

/// 0 超出最多时长完成,1 动手点击完成,
@property(nonatomic, assign) NSInteger type;

@property(nonatomic, copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
