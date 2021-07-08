//
//  UIView+AXKit.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXKitEnum.h"
#import "AXKitEnum.h"

NS_ASSUME_NONNULL_BEGIN

// 定义边框方向枚举
typedef NS_ENUM(NSInteger,AXLineDirection){
    AXLineDirectionTop = 1 << 0,
    AXLineDirectionBottom = 1 << 1,
    AXLineDirectionLeft = 1 << 2,
    AXLineDirectionRight = 1 << 3
};


@interface UIView (AXKit)
/**
 * 指定 角 进行圆角
 */
- (void)ax_roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat )cornerRadius;

/**
 * 左右颤动一下
 */
- (void)ax_shakeByLeftAndRight;

/**
 渐变色
 
 @param colorArray UIColor 数组
 */
- (void)ax_gradientColors:(NSArray <UIColor*>*)colorArray;


/// 设置背景渐变色
/// @param colorArray 颜色
/// @param orientation 方法
- (void)ax_setBackgroundGradientColors:(NSArray <UIColor*>*)colorArray
                           orientation:(AXOrientation )orientation;

/**
 为UIView的某个方向添加边框
 
 @param direction 边框方向
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)ax_addBorder:(AXBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width;

/**
 阴影
 当前veiw.layer.cornerRadius 后会和layer.shadowRadius 冲突
 
 @param shadowColor UIColor
 */
- (void)ax_shadowWith:(UIColor *)shadowColor;


/**
 * view 添加手势 成为点击事件
 */
- (void)ax_addViewActionBlock:(void(^)(id aView))block;

/**
 *  tag 只能是数字,
 *  所以定义一个string类型
 */
@property (nonatomic, copy)NSString *axTag;

/**
 找出绑定 ax_tag 的对象
 
 @param tag ax_tag
 @return view
 */
- (nullable __kindof UIView *)ax_viewWithTag:(NSString *)tag;

/**
 截屏 不含有转态栏  保存至相册
 */
- (void )ax_saveScreenShotsToPhotoAlbum;

/**
 当前view layer  重绘图片
 
 @return UIImage
 */
- (UIImage * )ax_drawRectToImage;

/**
 当前view layer  重绘图片,并保存到相册中
 */
- (void )ax_saveToPhotoAlbum;

/**
 layer 层 添加虚线
 
 @param lineLength 虚线每个长
 @param lineSpacing 虚线间隔
 @param lineColor 虚线颜色
 */
- (void)ax_addDottedLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 活动view响应 UIViewController
 
 @return UIViewController
 */
- (UIViewController *)ax_viewController;

/*!
 *  为本view添加边线
 *
 *  @param direction     边线方向 中间加 | 同时添加多个边框
 *  @param color         边框的颜色
 *  @param heightOrwidth 变量的宽度或者高度
 */
- (void)ax_addLineDirection:(AXLineDirection)direction color:(UIColor *)color height:(NSInteger)height;

/// UIBarButtonItem 尺寸约束
/// @param width 宽
/// @param height 高
-(void)ax_constraintButtonItemWidth:(CGFloat )width  height:(CGFloat )height;

/// 制作圆角（含部分圆角）
/// @param radius 圆角半径 只会影响背景色和边界，不会影响layer image content，如需裁切内容，参看masksToBounds属性
/// @param corners 圆角位置
/// @param masksToBounds 子layer是否剪切到layer的边界，为YES时会影响阴影的设置。
/// @Discussion
/// ⚠️低于iOS11的版本且为设置部分圆角的情况下，请在frame确认之后调用此方法。
///尤其是自动布局，可能需要先调用layoutIfNeeded确定frame之后再调用。低于iOS11的版本，设置圆角会影响阴影的设置，您可以使用额外的view来辅助显示阴影
- (void)ax_makeConerWithRadius:(CGFloat)radius
                       corners:(UIRectCorner)corners
                 masksToBounds:(BOOL)masksToBounds;
@end
NS_ASSUME_NONNULL_END
