//
//  CopyActivity.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/21.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "CopyActivity.h"

@implementation CopyActivity

- (NSString *)activityTitle {
    return @"复制";
}
- (UIImage *)activityImage {
    return [UIImage imageNamed:@"ax_icon_weixin"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}
@end
