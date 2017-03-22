//
//  UISlider+AXTool.h
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/16.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (AXTool)
/**
 * 按钮事件封装成block
 */
-(void)ax_addTargetBlock:(void(^)(UISlider *slider))block;

@end
