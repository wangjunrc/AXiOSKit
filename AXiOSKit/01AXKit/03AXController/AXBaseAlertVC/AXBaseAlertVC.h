//
//  AXBaseAlertVC.h
//  AXiOSKit
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXViewController.h"

typedef NS_ENUM(NSUInteger, AXAlertControllerStyle){
    AXAlertControllerStyleUpward = UIAlertControllerStyleActionSheet,// 从下往上
    AXAlertControllerStyleCentre = UIAlertControllerStyleAlert   // 从中间放大弹出
};

@interface AXBaseAlertVC : AXViewController

/**
 是否touchesBegan,dismiss
 */
@property (nonatomic, assign)BOOL axTouchesBeganDismiss;

/**
 子vc重写此方法,更改 alertControllerStyle 样式

 @return AXAlertControllerStyle
 */
- (AXAlertControllerStyle )axAlertControllerStyle;

@end
