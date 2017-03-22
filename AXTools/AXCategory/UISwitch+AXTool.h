//
//  UISwitch+AXTool.h
//  ZBP2P
//
//  Created by Mole Developer on 2017/1/3.
//  Copyright © 2017年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (AXTool)
/**
 * 按钮事件封装成block
 */
-(void)ax_addTargetBlock:(void(^)(UISwitch *aSwitch))block;
@end
