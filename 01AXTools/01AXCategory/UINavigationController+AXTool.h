//
//  UINavigationController+AXTool.h
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/29.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AXTool)

/**
 * 返回父指定控制器
 */
-(void)ax_popToViewControllerClass:(NSString *)classStr;

/**
 * push vc后移除当前控制器,让当前控制器作为viewController的父导航控制器
 */
- (void)pushViewControllerAndRemoveParent:(UIViewController *)viewController animated:(BOOL)animated;

/**
 * push vc后移除指定父nav控制器,
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated removeParent:(UIViewController *)parent;

/**
 初始化
 
 @param vcClass rootCalass
 @return 当前控制器
 */
+(instancetype)ax_navRootViewControllerClass:(Class)vcClass;

@end
