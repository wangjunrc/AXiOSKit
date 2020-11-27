//
//  AXBaseAlertVC.h
//  AXiOSKit
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXViewController.h"
#import "AXBaseAlertDefine.h"

__attribute__((deprecated("过期")));
@interface AXBaseAlertVC : AXViewController

/**
 是否touchesBegan,dismiss
 */
@property (nonatomic, assign,readonly)BOOL touchesBeganDismiss;

/**
 子vc重写此方法,更改 alertControllerStyle 样式

 @return AXAlertControllerStyle
 */
@property (nonatomic, assign,readonly)AXAlertControllerStyle alertControllerStyle;

@end
