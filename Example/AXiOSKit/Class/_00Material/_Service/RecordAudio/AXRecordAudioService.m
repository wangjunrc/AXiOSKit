//
//  AXRecordAudioService.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/12.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXRecordAudioService.h"

@interface AXRecordAudioService () <AVAudioRecorderDelegate>

@property(nonatomic, strong, readwrite) AXRecordAudioConfig *config;
@property(nonatomic, copy) void (^progressBlock)(NSProgress *progress);
@property(nonatomic, copy) void (^successBlock)(AXRecordAudioSuccess *result);
@property(nonatomic, copy) void (^failureBlock)(NSError *error);
@property(nonatomic, copy) NSString *autioPath;
@property(nonatomic, strong) AVAudioRecorder *recorder;
@property(nonatomic, strong) NSTimer *playTimer;

/// 完成类型 0自动完成, 1 手动点击完成
@property(nonatomic, assign) NSInteger completeType;

@end

@implementation AXRecordAudioService

AX_SINGLETON_IMPL()

- (AXRecordAudioService *_Nonnull (^)(AXRecordAudioConfig *_Nonnull))
withConfig {
    __weak typeof(self) weakSelf = self;
    return ^AXRecordAudioService *(AXRecordAudioConfig *config) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        strongSelf.config = config;
        return strongSelf;
    };
}

- (AXRecordAudioService *_Nonnull (^)(void (^_Nonnull)(NSProgress *_Nonnull)))
progress {
    __weak typeof(self) weakSelf = self;
    return ^AXRecordAudioService *(void (^progressBlock)(NSProgress *_Nonnull)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.progressBlock = progressBlock;
        return strongSelf;
    };
}

- (AXRecordAudioService *_Nonnull (^)(
                                      void (^_Nonnull)(AXRecordAudioSuccess *)))success {
    __weak typeof(self) weakSelf = self;
    return ^AXRecordAudioService *(
                                   void (^successBlock)(AXRecordAudioSuccess *result)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.successBlock = successBlock;
        return self;
    };
}

- (AXRecordAudioService *_Nonnull (^)(void (^_Nonnull)(NSError *_Nonnull)))
failure {
    __weak typeof(self) weakSelf = self;
    return ^AXRecordAudioService *(
                                   void (^failureBlock)(NSError *_Nonnull error)) {
        __strong typeof(weakSelf) self = weakSelf;
        self.failureBlock = failureBlock;
        return self;
    };
}

- (void (^)(void))start {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        strongSelf.completeType = 0;
        [strongSelf startRecording];
    };
}

- (void (^)(void))end {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [strongSelf finishRecording];
    };
}

- (void (^)(void))pause {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        if (strongSelf.recorder.isRecording) {
            [strongSelf.recorder pause];
        }
    };
}

/**
 开始录音前的工作，判断是否可以录音
 */
- (void)startRecording {
    __weak typeof(self) weakSelf = self;
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        __strong typeof(self) self = weakSelf;
        
        AVAuthorizationStatus status =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (granted) {
            
            if (status == AVAuthorizationStatusAuthorized) {
                [self startPreRecording];
            } else {
                
                if (self.failureBlock) {
                    NSError *error = [NSError ax_errorWithDescription:@"麦克风未授权"];
                    self.failureBlock(error);
                }
            }
        } else {
            if (self.failureBlock) {
                NSError *error =
                [NSError ax_errorWithDescription:@"麦克风开启授权失败"];
                self.failureBlock(error);
            }
        }
    }];
}

/**
 开始准备录音，前的设置工作后，启动录音
 */
- (void)startPreRecording {
    NSError *error;
    
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //设置录音格式
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC]
                     forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100]
                     forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1]
                     forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16]
                     forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh]
                     forKey:AVEncoderAudioQualityKey];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    [audioSession setActive:YES error:&error];
    
    if (error) {
        if (self.failureBlock) {
            self.failureBlock(error);
        }
        return;
    }
    
    NSString *filePath = [NSString ax_documentDirectory];
    if (self.config.filePath.length) {
        filePath = [filePath stringByAppendingPathComponent:self.config.filePath];
    }
    filePath = [filePath
                stringByAppendingPathComponent:
                [NSString stringWithFormat:@"%@.aac",
                 [NSString ax_stringRandomlyWithCount:5]]];
    
    self.autioPath =
    [[NSString ax_documentDirectory] stringByAppendingPathComponent:filePath];
    NSURL *url = [NSURL fileURLWithPath:self.autioPath];
    
    //初始化
    if (self.recorder) {
        self.recorder = nil;
    }
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url
                                                settings:recordSetting
                                                   error:&error];
    if (error) {
        if (self.failureBlock) {
            self.failureBlock(error);
        }
        return;
    }
    self.recorder.delegate = self;
    
    //开启音量检测
    self.recorder.meteringEnabled = YES;
    
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    //设置录音时长，超过这个时间后，会暂停单位是秒
    [self.recorder recordForDuration:self.config.maxDuration];
    
    //创建录音文件，准备录音
    if ([self.recorder prepareToRecord]) {
        //开始
        [self.recorder record];
    }
    
    self.playTimer =
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(playTimerAction)
                                   userInfo:nil
                                    repeats:YES];
}

/**
 主动调用 录音完成
 */
- (void)finishRecording {
    
    if (self.recorder.isRecording) {
        self.completeType = 1;
        /// 先停止录音
        if (self.recorder.isRecording) {
            [self.recorder stop];
        }
        return;
    }
    
    [self.recorder deleteRecording];
    if (self.failureBlock) {
        NSError *error = [NSError ax_errorWithDescription:@"未开始录音就结束"];
        self.failureBlock(error);
    }
}

/// 停止录音
- (void)_stopRecording {
    [self.recorder updateMeters];
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
}

/**
 取消录音
 */
- (void)cancleRecord {
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    [self.recorder stop];
}

/**
 暂停录音
 */
- (void)paseRecord {
}
- (void)resumeRecord {
}

- (void)playTimerAction {
    NSLog(@"=====调用录音定时器 %lf", self.recorder.currentTime);
}

#pragma mark - VAudioRecorderDelegate相关

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag {
    
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:recorder.url
                                                 options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    NSLog(@"录音代理完成 = %d 时长: %lf", flag, audioDurationSeconds);
    if (flag && (audioDurationSeconds >= self.config.minDuration)) {
        if (self.successBlock) {
            AXRecordAudioSuccess *result =
            AXRecordAudioSuccess.alloc.init;
            result.type = self.completeType;
            result.path = self.autioPath;
            self.successBlock(result);
        }
        
    } else {
        [self.recorder deleteRecording];
        if (self.failureBlock) {
            NSError *error = nil;
            if (flag && (audioDurationSeconds < self.config.minDuration)) {
                error =
                [NSError ax_errorWithDescription:
                 [NSString stringWithFormat:@"录音时长不能少于%.1lf秒",
                  self.config.minDuration]];
            } else {
                error = [NSError ax_errorWithDescription:@"系统异常"];
            }
            self.failureBlock(error);
        }
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder
                                   error:(NSError *)error {
    
    NSLog(@"解码错误 = %@", error);
    if (self.failureBlock) {
        NSError *error = [NSError ax_errorWithDescription:@"手机解码异常"];
        self.failureBlock(error);
    }
}

@end

