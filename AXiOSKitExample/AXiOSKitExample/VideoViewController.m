//
//  VideoViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/10.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "VideoViewController.h"
@import AVFoundation;
#import <AXiOSKit/AXiOSKit.h>
#import "LVieoView.h"

@interface VideoViewController ()

@property (nonatomic, strong) AVPlayer  *onlinePlayer;
/**
 * AVPlayerLayer *playerLayer
 */
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//   AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.onlinePlayer];
//
//    playerLayer.frame = CGRectMake(0, 100, 300, 300 );//放置播放器的视图
//    playerLayer.backgroundColor = UIColor.orangeColor.CGColor;
////   playerLayer.videoGravity = AVLayerVideoGravityResize;
//    [self.view.layer addSublayer:playerLayer];
//
//    self.playerLayer = playerLayer;
    
     NSString *url = @"http://127.0.0.1:8091/images/v0200f930000bpajn9hevctlh37upcj0.MP4";
    LVieoView *videoView = [[LVieoView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height/3)];
     videoView.videoUrl =url;
     [self.view addSubview:videoView];
     self.view.backgroundColor = [UIColor lightGrayColor];
     videoView.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)play:(id)sender {
    
    [self.onlinePlayer play];
}

- (AVPlayer *)onlinePlayer{
    if (!_onlinePlayer) {
        
//        NSString *path = @"http://127.0.0.1:8091/images/jm.mkv";
         NSString *url = @"http://127.0.0.1:8091/images/v0200f930000bpajn9hevctlh37upcj0.MP4";
       
        
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
        
        _onlinePlayer = [[AVPlayer alloc]initWithPlayerItem:item];
        
        [self func_addItemKVO:item];
        
    }
    return _onlinePlayer ;
}

/**
 * 添加 KVO
 */
-(void)func_addItemKVO:(AVPlayerItem *)playItem{
 
    
    
    [playItem ax_addKVOBlockForKeyPath:@"playbackBufferEmpty" block:^(AVPlayerItem *playerItem, id  _Nonnull oldVal, id  _Nonnull newVal) {
        
        NSLog(@"缓冲不足暂停了");
        
    }];
    
    
    [playItem ax_addKVOBlockForKeyPath:@"loadedTimeRanges" block:^(AVPlayerItem *playerItem,NSValue *oldVal, NSValue *newVal) {
        
        NSLog(@"获取缓冲区域 %@ >>  %@ >>  %@",playerItem,oldVal,newVal);
        
        NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        
        CMTime duration = playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        
        NSLog(@"下载进度：%.2f", timeInterval / totalDuration);
        
    }];
    
    
    //status 点进去看 有三种状态
    [playItem ax_addKVOBlockForKeyPath:@"status" block:^(AVPlayerItem *playerItem, id  _Nonnull oldVal, id  _Nonnull newVal) {
        
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            
            
            float total = CMTimeGetSeconds(playerItem.asset.duration);
            float totalminute = total/60;
           float totalsecond = ((NSInteger)total)%60;
            NSLog(@"准备好播放了，总时间：%.2lf:%.2lf", totalminute,totalsecond);//还可以获得播放的进度，这里可以给播放进度条赋值了
//
//            [self.timeLabel setText:[NSString stringWithFormat:@"00:00/%02ld:%02ld",(long)self.totalminute,(long)self.totalsecond]];
//            [self func_showZeroTime];
//
            
        } else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
            [self.onlinePlayer pause];
            NSLog(@"加载失败，网络或者服务器出现问题");
            
//            [self ax_showAlertByTitle:@"加载失败，网络或者服务器出现问题" certain:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
        }
    }];
    
    
    [playItem ax_addKVOBlockForKeyPath:@"playbackLikelyToKeepUp" block:^(AVPlayerItem *obj, NSNumber *oldVal, NSNumber *newVal) {
        
        NSLog(@"缓冲达到可播放程度了 %@ >>  %@ >>  %@",obj,oldVal,newVal);
       
        if (newVal.intValue ==1) {
            
            ;
        }
    }];
    
}



@end
