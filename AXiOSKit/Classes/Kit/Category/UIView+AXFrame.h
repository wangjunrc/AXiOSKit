/*直接修改View的尺寸,坐标*/

#import <UIKit/UIKit.h>

@interface UIView (AXFrame)
/**
 * 直接修改x值
 */
@property (nonatomic, assign) CGFloat x;

/**
 * 直接修改y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 * 直接修改中心x值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 * 直接修改中心y值
 */
@property (nonatomic, assign) CGFloat centerY;

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
@property (nonatomic, assign) CGFloat right;

/**
 *  左边距
 */
@property (nonatomic, assign, assign) CGFloat left;

/**
 *  上边距
 */
@property (nonatomic) CGFloat top;

/**
 *  下边距
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 * 移除所有子视图
 */
- (void)removeAllSubviews;


/*========================ax 前缀==================================*/
/**
 * 直接修改x值
 */
@property (nonatomic, assign) CGFloat ax_x;

/**
 * 直接修改y值
 */
@property (nonatomic, assign) CGFloat ax_y;

/**
 * 直接修改宽度
 */
@property (nonatomic, assign) CGFloat ax_width;

/**
 * 直接修改高度
 */
@property (nonatomic, assign) CGFloat ax_height;

/**
 * 直接修改中心x值
 */
@property (nonatomic, assign) CGFloat ax_centerX;

/**
 * 直接修改中心y值
 */
@property (nonatomic, assign) CGFloat ax_centerY;


/**
 * 直接修改尺寸
 */
@property (nonatomic, assign) CGSize ax_size;

/**
 * 直接修改原点
 */
@property (nonatomic, assign) CGPoint ax_origin;


/**
 *  上边距
 */
@property (nonatomic) CGFloat ax_top;

/**
 *  左边距
 */
@property (nonatomic, assign, assign) CGFloat ax_left;

/**
 *  下边距
 */
@property (nonatomic, assign) CGFloat ax_bottom;

/**
 *  右边距
 */
@property (nonatomic, assign) CGFloat ax_right;


/**
 * 移除所有子视图
 */
- (void)ax_removeAllSubviews;

@end
