//
//  UIButton+AXTool.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePosition) {
    ImagePositionLeft = 0,  // 图片在左，文字在右，默认
    ImagePositionRight,     // 图片在右，文字在左
    ImagePositionTop,       // 图片在上，文字在下
    ImagePositionBottom,    // 图片在下，文字在上
};

@interface UIButton (AXTool)

/**
 * 按钮事件封装成block
 */
-(void)ax_addTargetBlock:(void(^)(UIButton *button))block;



/**
 修改button 文字图片位置

 @param postion 枚举
 @param spacing 间隙
 */
- (void)setImagePosition:(ImagePosition)postion spacing:(CGFloat)spacing;


/**
 扩大按钮响应热区时，负值为扩大，正值为缩小。 完全支持自动布局，只需要将方法写在自动布局方法下面即可
 */
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
