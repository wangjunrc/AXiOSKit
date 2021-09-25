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

/// push 完成后,移除viewController的父视图
/// @param viewController viewController
/// @param animated 动画
/// @param replace 是否替换
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL )animated
                      replace:(BOOL )replace;

/**
 * push vc后移除指定父nav控制器,
 使用RTRootNavigationController 时,改方法  卡顿
 */
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                 removeParent:(UIViewController *)parent DEPRECATED_MSG_ATTRIBUTE("过期,该方法有bug");

/**
 * push vc后移除指定父VC
 */
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated removeVC:(UIViewController *)removeVC;

/**
 push vc后 移除 指定的vc 数组
 
 @param viewController vc
 @param animated animated
 @param vcArray vcArray
 */
- (void)ax_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated removeViewControllers:(NSArray *)vcArray;

/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+ (instancetype)ax_navRootViewControllerClass:(Class)vcClass;


/// push 动画类似 Present样式
/// @param controller controller
/// @param animated animated
-(void)ax_pushViewControllerPresentStyle:(UIViewController *)controller
                                animated:(BOOL )animated;


/// push 动画类似 Present样式 的pop返回
/// @param animated animated
-(void)ax_pophViewControllerPresentStyleAnimated:(BOOL )animated;

@end
