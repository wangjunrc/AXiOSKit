//
//  UINavigationController+AXTool.m
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/29.
//  Copyright © 2016年 mole. All rights reserved.
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
    
    NSMutableArray *temp =[self.viewControllers mutableCopy];
    
//    [temp removeObject:temp.lastObject];
    [temp removeObjectAtIndex:temp.count-2];
    self.viewControllers =temp;

}
/**
 * push vc后移除当前控制器,让当前控制器上一个作为viewController的父导航控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeParent:(UIViewController *)parent{
    
    [self pushViewController:viewController animated:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *temp =[self.viewControllers mutableCopy];
        if ([temp containsObject:parent]) {
            [temp removeObject:parent];
            self.viewControllers =temp;
        }
        
    });
  
   
    
}

@end
