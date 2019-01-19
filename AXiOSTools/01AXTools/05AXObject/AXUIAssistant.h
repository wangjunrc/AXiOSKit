//
//  AXUIAssistant.h
//  AXiOSTools
//
//  Created by AXing on 2019/1/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**UIScreen.mainScreen scale*/
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

extern CGFloat ax_safe_area_insets_top(void);

extern CGFloat ax_safe_area_insets_left(void);

extern CGFloat ax_safe_area_insets_bottom(void);

extern CGFloat ax_safe_area_insets_right(void);

extern UIEdgeInsets ax_screen_padding_insets(void);

extern CGFloat ax_screen_adaptive_float(CGFloat floatValue);

extern CGFloat ax_screen_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);

extern CGPoint ax_screen_adaptive_point(CGPoint pointValue);

extern CGSize ax_screen_adaptive_size(CGSize sizeValue);

extern CGRect ax_screen_adaptive_rect(CGRect rectValue);

extern CGFloat ax_screen_vertical_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding);




NS_ASSUME_NONNULL_END
