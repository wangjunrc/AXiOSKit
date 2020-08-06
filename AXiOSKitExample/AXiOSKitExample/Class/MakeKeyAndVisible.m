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
    
    
    [AXConfigureManager registerCatch];
    
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
    TableViewController *roorvc = [[TableViewController alloc]init];
    AANavigationController *nav = [[AANavigationController alloc]initWithRootViewController:roorvc];
    
    
    
    
    return nav;
    
    
    
}

@end
