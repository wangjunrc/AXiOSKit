//
//  SPTWindowViewController.m
//  SPTTestEnvironment
//
//  Created by dingyl on 2018/7/31.
//  Copyright © 2018年 suning. All rights reserved.
//

#import "SPTWindowViewController.h"
#import "SPTTestURLEnvironmentViewController.h"
#import "LLImageNameConfig.h"
#import "LLBaseNavigationController.h"
#import <objc/runtime.h>

typedef UITabBarController * (* _IMP)(id);

@implementation SPTWindowViewController

- (UITabBarController *)tabVC {
    Method originalMethod = class_getInstanceMethod(self.superclass, @selector(tabVC));
    _IMP tabVCImp = (_IMP)method_getImplementation(originalMethod);
    UITabBarController *vc = tabVCImp(self);
    
    NSArray *vcs = vc.viewControllers;
    
    NSMutableArray *children = [NSMutableArray arrayWithArray:vcs];
    
    BOOL flag = NO;
    for (UIViewController *child in vcs) {
        if ([child isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController*)child;
            if ([nav.viewControllers.firstObject isKindOfClass:[SPTTestURLEnvironmentViewController class]]) {
             flag = YES;
             break;
            }
        }
    }
    if (!flag) {
        SPTTestURLEnvironmentViewController *urlVC = [[SPTTestURLEnvironmentViewController alloc] init];
        LLBaseNavigationController *environmentNav = [[LLBaseNavigationController alloc] initWithRootViewController:urlVC];
        environmentNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Environment" image:[UIImage LL_imageNamed:kAppImageName] selectedImage:nil];
        [children insertObject:environmentNav atIndex:0];
        
        vc.viewControllers = children;
    }

    return vc;
}

@end
