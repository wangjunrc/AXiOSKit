//
//  DemoBaseCollectionViewController.m
//  AXiOSKit
//
//  Created by axinger on 2021/9/26.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DemoBaseCollectionViewController.h"

@interface DemoBaseCollectionViewController ()

@end

@implementation DemoBaseCollectionViewController

/// 指定控制器旋转: 基类：默认不支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}

/// 指定控制器旋转: 默认支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
