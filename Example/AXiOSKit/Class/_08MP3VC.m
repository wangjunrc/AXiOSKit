//
//  _39MP3VC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/4/14.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_08MP3VC.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>

#import <AudioToolbox/AudioToolbox.h>

@interface _08MP3VC ()<AVAudioPlayerDelegate>

///AVAudioPlayer是不支持播放在线音频的
@property(nonatomic,strong)AVAudioPlayer *musicPlayer;

@property (nonatomic, strong) AVPlayer  *onlinePlayer;

@end

@implementation _08MP3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"音频播放";
    
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"播放音频" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _init];
    }];
    [self _buttonTitle:@"暂停音频" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.musicPlayer pause];
    }];
    [self _buttonTitle:@"系统声音" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _sound];
    }];
    
    [self _lastLoadBottomAttribute];
}

-(void)_init {
    
    /// 监听耳机是一个系统的单例方法,通过发送通知来做操作
    [[AVAudioSession sharedInstance] setActive:YES error:nil];//创建单例对象并且使其设置为活跃状态.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:)  name:AVAudioSessionRouteChangeNotification object:nil];//设置通知
    
    
    
    NSError *myErr;
    
    // Initialize the AVAudioSession here.
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr]) {
        // Handle the error here.
        NSLog(@"Audio Session error %@, %@", myErr, [myErr userInfo]);
    }
    else{
        // Since there were no errors initializing the session, we'll allow begin receiving remote control events
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Cocoanetics_031" ofType:@"mp3"];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    //    self.musicPlayer.delegate = self;
    self.musicPlayer.delegate = self;
    
    [self.musicPlayer prepareToPlay];
    [self.musicPlayer play];
    
    
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        NSMutableDictionary *dict = [ [NSMutableDictionary alloc] init];
        MPMediaItemArtwork *albumArt = [ [MPMediaItemArtwork alloc] initWithImage: [UIImage imageNamed:@"西瓜"] ];
        [dict setObject: @"Title" forKey:MPMediaItemPropertyTitle ];
        [dict setObject: @"作者" forKey:MPMediaItemPropertyArtist ];
        [dict setObject: @"AlbumTitle" forKey:MPMediaItemPropertyAlbumTitle ];
        [dict setObject: albumArt forKey:MPMediaItemPropertyArtwork ];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict ];
    }
}

- (void)audioRouteChangeListenerCallback:(NSNotification*)notification {
    
    NSDictionary *interuptionDict = notification.userInfo;
    AVAudioSessionRouteChangeReason routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:{
            NSLog(@"耳机插入");
            [self.musicPlayer play];
        }
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:{
            //耳机拔出
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                //做操作,用主线程调用,如果不用主线程会报黄,提示,从一个线程跳到另一个线程容易产生崩溃,所以这里要用主线程去做操作
                [strongSelf.musicPlayer pause];
            });
        }
            break;
        default:
            break;
            
    }
}

-(void)_sound {
    /// https://iphonedev.wiki/index.php/AudioServices
    //播放系统提示音,通过自动定义好的soundID就可以直接播放
    SystemSoundID soundIDTest = 1007;
    AudioServicesPlaySystemSound(soundIDTest);
}

@end
