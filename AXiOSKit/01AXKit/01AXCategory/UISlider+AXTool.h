//
//  UISlider+AXTool.h
//  AXiOSKit
//
//  Created by liuweixing on 2016/12/16.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (AXTool)
/**
 * 按钮事件封装成block
 */
- (void)ax_addActionBlock:(void(^)(UISlider *slider))block;

@end
