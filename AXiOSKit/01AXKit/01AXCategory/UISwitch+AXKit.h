//
//  UISwitch+AXKit.h
//  AXiOSKit
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (AXKit)

/**
 * 按钮事件封装成block
 */
- (void)ax_addActionBlock:(void(^)(UISwitch *aSwitch))block;

@end
