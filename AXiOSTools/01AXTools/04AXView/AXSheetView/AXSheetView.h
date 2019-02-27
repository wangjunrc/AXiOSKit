//
//  AXSheetView.h
//  AXiOSTools
//
//  Created by AXing on 2019/2/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 view中,由下向上动画显示,一般使用AXBaseAlertVC,但是个别情况viewController不能控制的使用view
 */
@interface AXSheetView : UIView


/**
 继承 AXSheetView 的 子控件都添加在 contentView 上
 */
@property(nonatomic,strong)UIView *contentView;

- (void)showSheetView;

- (void)dismissSheetView;

@end

NS_ASSUME_NONNULL_END
