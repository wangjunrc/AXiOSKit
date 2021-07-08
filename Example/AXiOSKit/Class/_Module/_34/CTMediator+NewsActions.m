//
//  CTMediator+NewsActions.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/23.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "CTMediator+NewsActions.h"
#import <UIKit/UIKit.h>

/// @"News" 必须对应  // Target_xx 格式中的xx
NSString * const kCTMediatorTarget_News = @"News";
NSString * const kCTMediatorActionNativTo_NewsViewController = @"NativeToNewsViewController";

@implementation CTMediator (NewsActions)

- (UIViewController *)yt_mediator_newsViewControllerWithParams:(NSDictionary *)dict {
    UIViewController *viewController =  [self performTarget:kCTMediatorTarget_News action:kCTMediatorActionNativTo_NewsViewController params:dict shouldCacheTarget:YES];
  
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    } else {
        NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
        return [[UIViewController alloc] init];
    }
}

@end
