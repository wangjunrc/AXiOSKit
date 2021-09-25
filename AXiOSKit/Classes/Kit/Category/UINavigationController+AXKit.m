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
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                 removeParent:(UIViewController *)parent{
    
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
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
        removeViewControllers:(NSArray *)vcArray{
    
    [self pushViewController:viewController animated:animated];
    
    NSMutableArray *temp =[self.viewControllers mutableCopy];
    [temp removeObjectsInArray:vcArray];
    self.viewControllers =temp;
}

/**
 * push vc后移除指定父VC
 */
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                     removeVC:(UIViewController *)removeVC {
    
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


/// push 完成后,移除viewController的父视图
/// @param viewController viewController
/// @param animated 动画
/// @param replace 是否替换
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL )animated
                      replace:(BOOL )replace {
    
//    [CATransaction setCompletionBlock:^{
        //        NSMutableArray<UIViewController *> *tempArray = self.viewControllers.mutableCopy;
        //        NSInteger index = [tempArray indexOfObject:viewController];
        //        if (index > 0) {
        //            [tempArray removeObjectAtIndex:index-1];
        //            self.viewControllers = tempArray.copy;
        //        }
//    }];
//    [CATransaction begin];
    
    if (replace) {
        NSMutableArray<UIViewController *> *tempArray = self.viewControllers.mutableCopy;
        if (tempArray.count > 0) {
            [tempArray removeObjectAtIndex:tempArray.count-1];
            self.viewControllers = tempArray.copy;
        }
    }
    [self pushViewController:viewController animated:animated];
//    [CATransaction commit];
    
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
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                     complete:(void(^)(void))complete{
    
    [CATransaction setCompletionBlock:^{
        if (complete) {
            complete();
        }
    }];
    [CATransaction begin];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}




/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+ (instancetype)ax_navRootViewControllerClass:(Class)vcClass{
    
    return [[self alloc]initWithRootViewController:[[vcClass alloc]init]];
    
}

-(void)ax_pushViewControllerPresentStyle:(UIViewController *)viewController
                                animated:(BOOL )animated {
    
    if (animated) {
        animated = NO;
        CATransition *transition = [CATransition.alloc init];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.view.window.layer addAnimation:transition forKey:kCATransition];
    }
    [self pushViewController:viewController animated:animated];
    
}

-(void)ax_pophViewControllerPresentStyleAnimated:(BOOL )animated {
    
    if (animated) {
        animated = NO;
        CATransition *transition = [CATransition.alloc init];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.view.window.layer addAnimation:transition forKey:kCATransition];
    }
    [self popViewControllerAnimated:animated];
}

@end
