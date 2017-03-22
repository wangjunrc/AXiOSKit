//
//  CALayer+AXFrame.h
//  AXTools
//
//  Created by Mole Developer on 16/10/14.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
 * CALayer 没有center
 */
@interface CALayer (AXFrame)

/**
 * 直接修改x值
 */
@property (nonatomic, assign) CGFloat x;

/**
 * 直接修改y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 * 直接修改宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 * 直接修改高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 * 直接修改尺寸
 */
@property (nonatomic, assign) CGSize size;

/**
 * 直接修改原点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  右边距
 */
@property(nonatomic) CGFloat right;

/**
 *  左边距
 */
@property(nonatomic) CGFloat left;

/**
 *  上边距
 */
@property(nonatomic) CGFloat top;

/**
 *  下边距
 */
@property(nonatomic) CGFloat bottom;

@end
