//
//  UIView+AXSheet.h
//  AXiOSKit
//
//  Created by axing on 2019/3/1.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AXSheet)


/**
 *  show view 由下向上动画显示
 *  self 背景色请设置透明或者 白色,内部已经设置透明度0.3
 *  self 需要是一个容器view,会被父视图frame一致,
 */
- (void)ax_showSheet;

/**
 *  dismiss view 无动画
 */
- (void)ax_dismissSheet;

@end

NS_ASSUME_NONNULL_END
