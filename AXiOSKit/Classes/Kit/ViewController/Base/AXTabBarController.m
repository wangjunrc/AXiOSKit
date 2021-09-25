//
//  AXTabBarController.m
//  AXiOSKit
//
//  Created by liuweixing on 16/10/14.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXTabBarController.h"

@interface AXTabBarController ()

@end

@implementation AXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitle];
}
#pragma mark - 主题字体颜色等
- (void)setupTitle{
    NSDictionary *noDic= @{NSForegroundColorAttributeName : [UIColor grayColor]};
    NSDictionary *seDic= @{NSForegroundColorAttributeName : [UIColor redColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:noDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:seDic forState:UIControlStateSelected];
    //    [self.tabBarItem setTitleTextAttributes:noDic forState:UIControlStateNormal];
    //    [self.tabBarItem setTitleTextAttributes:seDic forState:UIControlStateSelected];
    
    self.tabBar.tintColor = [UIColor greenColor];
    self.tabBar.unselectedItemTintColor = [UIColor purpleColor];
    /// 背景色
    [self.tabBar setBarTintColor:UIColor.orangeColor];
    
    
}

/// 三、跟视图为UITabBarController(在UITabBarController中设置)

//6.0之后系统调用该方法

//- (BOOL)shouldAutorotate{
//    
//    //返回顶层视图的设置（顶层控制器需要覆盖shouldAutorotate方法）
//    
//    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
//    
//    return nav.topViewController.shouldAutorotate;
//    
////    return NO;
//}
//
//
//
////6.0之后系统调用该方法
//
//-(UIInterfaceOrientationMask )supportedInterfaceOrientations{
//    
//    //返回顶层视图支持的旋转方向
//    
//    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
//    
//    return nav.topViewController.supportedInterfaceOrientations;
//}
@end
