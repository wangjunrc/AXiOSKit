//
//  AppDelegateWebImage.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/14.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateWebImage.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>

@implementation AppDelegateWebImage

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
//    SDImageCache *imageCache=[SDImageCache.alloc initWithNamespace:@"image"];
//    [imageCache queryCacheOperationForKey:@"ax.key" done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
//
//    }];

    /// 缓存路径
    SDImageCache.defaultDiskCacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"com.ax.cache"];
    
    /// Add a custom read-only cache path
    /// 附加高速缓存路径块
    [SDImageCache sharedImageCache].additionalCachePathBlock = ^NSString * _Nullable(NSString * _Nonnull key) {
        NSString *bundledPath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"CustomPathImages"];
        NSLog(@"bundledPath %@",bundledPath);
        NSString *fileName = [[SDImageCache sharedImageCache] cachePathForKey:key].lastPathComponent;
        return [bundledPath stringByAppendingPathComponent:fileName.stringByDeletingPathExtension];
    };
    
    if (@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)) {
        // iOS 14 supports WebP built-in
        [[SDImageCodersManager sharedManager] addCoder:[SDImageAWebPCoder sharedCoder]];
    } else {
        // iOS 13 does not supports WebP, use third-party codec
        [[SDImageCodersManager sharedManager] addCoder:[SDImageWebPCoder sharedCoder]];
    }
    if (@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)) {
        // For HEIC animated image. Animated image is new introduced in iOS 13, but it contains performance issue for now.
        [[SDImageCodersManager sharedManager] addCoder:[SDImageHEICCoder sharedCoder]];
    }
    
    return YES;
}
@end
