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

@end
