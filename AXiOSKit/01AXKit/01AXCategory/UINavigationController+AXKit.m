//
//  UINavigationController+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 2016/12/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UINavigationController+AXKit.h"

@implementation UINavigationController (AXKit)

/**
 * 返回父指定控制器
 */
- (void)ax_popToViewControllerClass:(NSString *)classStr{
    
    for (UIViewController *temp in self.viewControllers) {
        
        if ([temp isKindOfClass:NSClassFromString(classStr)]) {
            [self popToViewController:temp animated:YES];
            break;
        }
    }
}



/**
 * push vc后移除指定父 VC
 使用RTRootNavigationController 时,改方法  卡顿
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeParent:(UIViewController *)parent{
    
    [self pushViewController:viewController animated:animated];
    
    if ([self.viewControllers containsObject:parent]) {
        
        NSMutableArray *temp =[self.viewControllers mutableCopy];
        [temp removeObject:parent];
        self.viewControllers =temp;
    }
  
}


/**
 push vc后 移除 指定的vc 数组
 
 @param viewController vc
 @param animated animated
 @param vcArray vcArray
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeViewControllers:(NSArray *)vcArray{
    
    [self pushViewController:viewController animated:animated];
   
    NSMutableArray *temp =[self.viewControllers mutableCopy];
    [temp removeObjectsInArray:vcArray];
    self.viewControllers =temp;
}

/**
 * push vc后移除指定父VC
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeVC:(UIViewController *)removeVC {
    
    
    UIViewController *rootVC = self.viewControllers.lastObject;
    
    if ([self.viewControllers containsObject:removeVC]) {
        
        NSMutableArray *temp =[self.viewControllers mutableCopy];
        [temp removeObject:removeVC];
        [self setViewControllers:temp animated:NO];
        rootVC = temp.lastObject;
    }
    [rootVC.navigationController pushViewController:viewController animated:animated];
    
}

- (void)ax_removeViewControllers:(NSArray *)vcArray{
    
   NSMutableArray *temp =[self.viewControllers mutableCopy];
    [temp removeObjectsInArray:vcArray];
    self.viewControllers =temp;
    
}


/**
 * push vc后移除指定父nav控制器,
 */

/**
 pushViewController 添加 complete

 @param viewController vc
 @param animated 动画
 @param complete 完成回调
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))complete{
    
    
    [self pushViewController:viewController animated:animated];
    
}




/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+ (instancetype)ax_navRootViewControllerClass:(Class)vcClass{
    
    return [[self alloc]initWithRootViewController:[[vcClass alloc]init]];
    
}

@end
