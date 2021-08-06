//
//  DemoBaseViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/1.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DemoBaseViewController.h"

@interface DemoBaseViewController ()

@end

@implementation DemoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    /// 这个不要放在 UINavigationController 里面
//    self.navigationController.navigationBar.topItem.title= @"";
    
}

- (void)clickBackLastPageAction {
    [self.navigationController popViewControllerAnimated:YES];
}






//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.nowViewCTRL = self;
//}


/// 指定控制器旋转: 基类：默认不支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}

/// 指定控制器旋转: 默认支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
