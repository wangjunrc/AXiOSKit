//
//  AXNavigationController.m
//  AXiOSKit
//
//  Created by liuweixing on 16/6/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNavigationController.h"
#import "AXiOSKit.h"
@interface AXNavigationController ()

@end

@implementation AXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 背景色
    self.navigationBar.barTintColor = [UIColor redColor];
    
    /// 返回按钮 颜色
    self.navigationBar.tintColor = [UIColor greenColor];
    
    //状态栏颜色
    self.navigationBar.barStyle = UIBarStyleDefault;
    //半透明--- view坐标为0,0, NO view坐标为0,64
    self.navigationBar.translucent = NO;
    //取消导航白线
    [self.navigationBar setShadowImage:[UIImage new]];
    
    //  R255 G127 B0
//    self.navigationBar.barTintColor = [UIColor colorWithRed:255 green:127 blue:0 alpha:1];
//
//    // UINavigationBar itme 图片文字渲染颜色
//    self.navigationBar.tintColor=[UIColor blackColor];
//    
//    //title 颜色
//    NSDictionary *dic = @{ NSForegroundColorAttributeName :[UIColor blackColor] };
//    self.navigationBar.titleTextAttributes = dic;
    
   
}

//- (UIStatusBarStyle)preferredStatusBarStyle{//没有导航栏的vc重写此方法,改变状态栏颜色
//    return UIStatusBarStyleLightContent;
//}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc{
    
    axLong_dealloc;
}
/// OS 14 push多个控制器，返回到根控制器，发现tabbar消失的问题
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    if (self.childViewControllers.count > 0) {
//
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        // 解决push多个控制器后，popToRootViewController TabBar消失
//        if (self.childViewControllers.count > 1) {
//            viewController.hidesBottomBarWhenPushed = NO;
//        }
//    }
//   
// 
//    [super pushViewController:viewController animated:animated];
//}

@end
