//
//  IBUIImageView.h
//  AXiOSKit
//
//  Created by liuweixing on 16/8/1.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface IBUIImageView : UIImageView

/**
 可视化设置边masksToBounds
 */
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;

/**
 *  设置圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  设置边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 *  设置边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
