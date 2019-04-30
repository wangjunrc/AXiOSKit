//
//  UINavigationController+AXKit.h
//  AXiOSKit
//
//  Created by liuweixing on 2016/12/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AXKit)

/**
 * 返回父指定控制器
 */
- (void)ax_popToViewControllerClass:(NSString *)classStr;

/**
 * push vc后移除指定父nav控制器,
 使用RTRootNavigationController 时,改方法  卡顿
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeParent:(UIViewController *)parent DEPRECATED_MSG_ATTRIBUTE("过期,该方法有bug");

/**
 * push vc后移除指定父VC
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeVC:(UIViewController *)removeVC;

/**
  push vc后 移除 指定的vc 数组

 @param viewController vc
 @param animated animated
 @param vcArray vcArray
 */
- (void)ax_pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeViewControllers:(NSArray *)vcArray;

/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+ (instancetype)ax_navRootViewControllerClass:(Class)vcClass;

@end
