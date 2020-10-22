//
//  Application.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/22.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "Application.h"

@implementation Application

- (instancetype)init {
    self = [super init];
    if (self) {
        //图标更换需要iOS10.3及以后版本支持
        if (@available(iOS 10.3, *)) {
            if (self.supportsAlternateIcons) {
                [self setAlternateIconName:@"g2" completionHandler:^(NSError * _Nullable error) {
                    NSLog(@"替换icon error = %@",error);
                }];
            }
        }
    }
    return self;
}

- (void)sendEvent:(UIEvent *)event{
   // 在这里处理一些统一的逻辑
   [super sendEvent:event];
//    NSLog(@"sendEvent====");
}
- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event{
//    NSLog(@"sendAction======");
    
   // 在这里处理一些统一的逻辑， 例如 记录行为日志
  return  [super sendAction:action to:target from:sender forEvent:event];
}

- (BOOL)openURL:(NSURL *)url{
//    NSLog(@"url ==== %@",url);
    if ([url.absoluteString isEqualToString:@"https://www.baidu.com/"]) {
        return NO;
    }
    return [super openURL:url];
}

@end
