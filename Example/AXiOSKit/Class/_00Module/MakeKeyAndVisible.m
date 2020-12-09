//
//  MakeKeyAndVisible.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/6/10.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "MakeKeyAndVisible.h"

#import <SDWebImageWebPCoder/SDImageWebPCoder.h>
#import <SDWebImage/SDImageCodersManager.h>
#import "_00TableViewController.h"
#import "AANavigationController.h"
#import <AXiOSKit/AXConfigureManager.h>
#import "_00SecondTableViewController.h"
#import "AXTabBarController.h"

@implementation MakeKeyAndVisible


+(UIViewController *)makeKeyAndVisible{
    
    [self loadSettingsBundle];
    //    [AXConfigureManager registerCatch];
    
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
    
    NSMutableArray<UIViewController *> *temp = [NSMutableArray array];
    
    {
        
        _00TableViewController *roorvc = [[_00TableViewController alloc]init];
        AANavigationController *nav = [[AANavigationController alloc]initWithRootViewController:roorvc];
        
        nav.tabBarItem.title=@"控制器";
        nav.tabBarItem.image=[UIImage imageNamed:@"tab_1"];
        nav.tabBarItem.badgeValue=@"1";
//        NSDictionary *noDic= @{NSForegroundColorAttributeName : [UIColor grayColor]};
//        NSDictionary *seDic= @{NSForegroundColorAttributeName : [UIColor redColor]};
//        [nav.tabBarItem setTitleTextAttributes:noDic forState:UIControlStateNormal];
//        [nav.tabBarItem setTitleTextAttributes:seDic forState:UIControlStateSelected];
//        nav.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%@",picArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                //设置选中时的图片
//        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%@_hl",picArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
        
        [temp addObject:nav];
    }
    {
        
        _00SecondTableViewController *roorvc = [[_00SecondTableViewController alloc]init];
        AANavigationController *nav = [[AANavigationController alloc]initWithRootViewController:roorvc];
        
        nav.tabBarItem.title=@"测试";
        nav.tabBarItem.image=[UIImage imageNamed:@"tab_2"];
//        NSDictionary *noDic= @{NSForegroundColorAttributeName : [UIColor grayColor]};
//        NSDictionary *seDic= @{NSForegroundColorAttributeName : [UIColor redColor]};
//        [nav.tabBarItem setTitleTextAttributes:noDic forState:UIControlStateNormal];
//        [nav.tabBarItem setTitleTextAttributes:seDic forState:UIControlStateSelected];
        
        [temp addObject:nav];
    }
    
    
    AXTabBarController *tabBar = [[AXTabBarController alloc]init];
    tabBar.viewControllers= temp.copy;
    
    return tabBar;
    
}




// 加载设置文件
+ (void)loadSettingsBundle
{
    id version =  [NSUserDefaults.standardUserDefaults objectForKey:@"version"];
    NSLog(@"version %@",version);
    [NSUserDefaults.standardUserDefaults setObject:@"123" forKey:@"version"];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    id aihao =  [NSUserDefaults.standardUserDefaults objectForKey:@"aihao"];
    NSLog(@"aihao %@",aihao);
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"加载Settings.bundle文件失败");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSLog(@"settings = %@",settings);
    
    //    NSMutableDictionary *defaultsToRegister = [NSMutableDictionary dictionary];
    //    defaultsToRegister[@"version"] = @"222";
    //    defaultsToRegister[@"aihao"] = @"swimming";
    //
    //    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


@end
