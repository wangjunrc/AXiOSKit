//
//  RouterManager.m
//  AXiOSKitExample
//
//  Created by 小星星MacBook on 2020/8/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//



#import "_AXTestRouterManager.h"
#import <MGJRouter/MGJRouter.h>

#import "_01ContentViewController.h"
@implementation _AXTestRouterManager

+ (void)load {
    [MGJRouter registerURLPattern:routeNameWith01ViewController toHandler:^(NSDictionary *routerParameters) {
        
        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][@"navigationController"];
        
        _01ContentViewController *testVC = [[_01ContentViewController alloc] init];
        [navigationController pushViewController:testVC animated:YES];
    }];
    
}


+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion {
    
    [MGJRouter openURL:URL withUserInfo:userInfo completion:completion];
}


@end
