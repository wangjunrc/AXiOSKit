//
//  DemoBaseTableViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/1.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DemoBaseTableViewController.h"

@interface DemoBaseTableViewController ()

@end

@implementation DemoBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/// 指定控制器旋转: 基类：默认不支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}

/// 指定控制器旋转: 默认支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
