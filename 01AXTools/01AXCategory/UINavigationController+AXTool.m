//
//  UINavigationController+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UINavigationController+AXTool.h"

@implementation UINavigationController (AXTool)

/**
 * 返回父指定控制器
 */
-(void)ax_popToViewControllerClass:(NSString *)classStr{
    
    for (UIViewController *temp in self.viewControllers) {
        
        if ([temp isKindOfClass:NSClassFromString(classStr)]) {
            [self popToViewController:temp animated:YES];
            break;
        }
    }
}

/**
 * push vc后移除当前控制器,让当前控制器上一个作为viewController的父导航控制器
 */
- (void)pushViewControllerAndRemoveParent:(UIViewController *)viewController animated:(BOOL)animated{
    
    [self pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count>2) {
        
        NSMutableArray *temp =[self.viewControllers mutableCopy];
        [temp removeObjectAtIndex:temp.count-2];
        self.viewControllers =temp;
    }
    

}

/**
 * push vc后移除指定父nav控制器,
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeParent:(UIViewController *)parent{
    
    [self pushViewController:viewController animated:animated];
    if ([self.viewControllers containsObject:parent]) {
        NSMutableArray *temp =[self.viewControllers mutableCopy];
        [temp removeObject:parent];
        self.viewControllers =temp;
    }
}

/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+(instancetype)ax_navRootViewControllerClass:(Class)vcClass{
    
    return [[self alloc]initWithRootViewController:[[vcClass alloc]init]];
    
}

@end
