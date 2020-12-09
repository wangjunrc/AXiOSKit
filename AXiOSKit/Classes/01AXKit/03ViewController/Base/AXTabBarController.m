//
//  AXTabBarController.m
//  AXiOSKit
//
//  Created by liuweixing on 16/10/14.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXTabBarController.h"
#import "AXiOSKit.h"

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


@end
