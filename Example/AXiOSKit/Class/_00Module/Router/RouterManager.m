//
//  RouterManager.m
//  AXiOSKitExample
//
//  Created by 小星星MacBook on 2020/8/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//



#import "RouterManager.h"
#import <MGJRouter/MGJRouter.h>
#import "_01ThemeViewController.h"

@implementation RouterManager

+ (void)load {
    [MGJRouter registerURLPattern:routeNameWith01ViewController toHandler:^(NSDictionary *routerParameters) {
        
        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][@"navigationController"];
        
        _01ThemeViewController *testVC = [[_01ThemeViewController alloc] init];
        [navigationController pushViewController:testVC animated:YES];
    }];
    
}


+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion {
    
    [MGJRouter openURL:URL withUserInfo:userInfo completion:completion];
}


@end
