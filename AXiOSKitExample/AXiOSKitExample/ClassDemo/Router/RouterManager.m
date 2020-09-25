//
//  RouterManager.m
//  AXiOSKitExample
//
//  Created by 小星星MacBook on 2020/8/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//



#import "RouterManager.h"
#import <MGJRouter/MGJRouter.h>
#import "_09AFNViewController.h"

@implementation RouterManager

+ (void)load {
    [MGJRouter registerURLPattern:routeNameOf toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        
        _09AFNViewController *testVC = [[_09AFNViewController alloc] init];
        [navigationController pushViewController:testVC animated:YES];
    }];
    
}


+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion {
    
    [MGJRouter openURL:URL withUserInfo:userInfo completion:completion];
}


@end
