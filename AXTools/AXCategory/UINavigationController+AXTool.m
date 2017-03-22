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

@end
