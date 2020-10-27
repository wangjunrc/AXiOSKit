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



@implementation MakeKeyAndVisible


+(UIViewController *)makeKeyAndVisible{
    
    [self loadSettingsBundle];
//    [AXConfigureManager registerCatch];
    
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
    _00TableViewController *roorvc = [[_00TableViewController alloc]init];
    AANavigationController *nav = [[AANavigationController alloc]initWithRootViewController:roorvc];
    return nav;
    
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
