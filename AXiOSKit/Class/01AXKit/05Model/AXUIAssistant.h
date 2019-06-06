//
//  AXUIAssistant.h
//  AXiOSKit
//
//  Created by AXing on 2019/1/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**屏宽比*/
extern CGFloat ax_screen_scale(void);

/**屏宽*/
extern CGFloat ax_screen_width(void);

/**屏高*/
extern CGFloat ax_screen_height(void);

/**竖屏宽*/
extern CGFloat ax_screen_width_in_portrait(void);

/**竖屏高*/
extern CGFloat ax_screen_height_in_portrait(void);

/**横屏宽*/
extern CGFloat ax_screen_width_in_landscape(void);

/**横屏高*/
extern CGFloat ax_screen_height_in_landscape(void);

extern CGFloat ax_screen_center_x(void);

extern CGFloat ax_pixel(void);


/**导航栏高+状态栏高 44+20或者44+44*/
extern CGFloat ax_navigation_and_status_height(void);

/**状态态栏高 20或者44*/
extern CGFloat ax_status_bar_height(void);
/**导航栏高 44*/
extern CGFloat ax_navigation_bar_height(void);

/**安全区域 UIEdgeInsets*/
extern UIEdgeInsets ax_safe_area_insets(void);

extern UIEdgeInsets ax_screen_padding_insets(void);

/**安全区域 UIEdgeInsets top, 状态栏高度 20 或者 44*/
extern CGFloat ax_safe_area_insets_top(void);

/**安全区域 UIEdgeInsets left*/
extern CGFloat ax_safe_area_insets_left(void);

/**安全区域 UIEdgeInsets bottom*/
extern CGFloat ax_safe_area_insets_bottom(void);

/**安全区域 UIEdgeInsets righ*/
extern CGFloat ax_safe_area_insets_right(void);

extern CGFloat ax_screen_adaptive_float(CGFloat floatValue);

extern CGFloat ax_screen_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);

extern CGPoint ax_screen_adaptive_point(CGPoint pointValue);

extern CGSize ax_screen_adaptive_size(CGSize sizeValue);

extern CGRect ax_screen_adaptive_rect(CGRect rectValue);

extern CGFloat ax_screen_vertical_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);

/**
 是否 nil 或者 空
 不要用分类, 为nil 时,不走分类方法
 */
extern BOOL ax_is_null(id obj);

/**
 是否不为 nil 或者 空
 */
extern BOOL ax_is_no_null(id obj);
