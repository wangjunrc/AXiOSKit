//
//  MyActivity.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/21.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_AXTestActivity2.h"

@implementation _AXTestActivity2

- (NSString *)activityTitle {
    return @"我的复制";
}
- (UIImage *)activityImage {
    return [UIImage imageNamed:@"ax_icon_weixin"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

@end
