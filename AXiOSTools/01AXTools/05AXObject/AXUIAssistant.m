//
//  AXUIAssistant.m
//  AXiOSTools
//
//  Created by AXing on 2019/1/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXUIAssistant.h"

CGFloat ax_screen_scale(void) {
    CGFloat scale = ([UIScreen instancesRespondToSelector:@selector(scale)] ? [UIScreen.mainScreen scale] : (1.0f));
    return scale;
}


CGFloat ax_screen_width(void) {
    CGFloat width = ([UIScreen.mainScreen bounds].size.width);
    return width;
}


CGFloat ax_screen_height(void) {
    CGFloat height = ([UIScreen.mainScreen bounds].size.height);
    return height;
}


CGFloat ax_screen_width_in_portrait(void) {
    return MIN(ax_screen_width(), ax_screen_height());
}


CGFloat ax_screen_height_in_portrait(void) {
    return MAX(ax_screen_width(), ax_screen_height());
}


CGFloat ax_screen_width_in_landscape(void) {
    return MAX(ax_screen_width(), ax_screen_height());
}


CGFloat ax_screen_height_in_landscape(void) {
    return MIN(ax_screen_width(), ax_screen_height());
}


CGFloat ax_screen_center_x(void) {
    CGFloat centerX = ax_screen_width() * 0.5f;
    return centerX;
}


CGFloat ax_pixel(void) {
    static CGFloat pixel = 1.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pixel = 1.0f / ax_screen_scale();
    });
    return pixel;
}

/**导航栏高+状态栏高 44+20或者44+44*/
CGFloat ax_navigation_and_status_height(void) {
    return ax_status_bar_height() + ax_navigation_bar_height();
}

CGFloat ax_status_bar_height(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

CGFloat ax_navigation_bar_height(void) {
    return 44.0f;
}

UIEdgeInsets ax_safe_area_insets(void) {
    if ([UIView instancesRespondToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            return UIApplication.sharedApplication.delegate.window.safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}


CGFloat ax_safe_area_insets_top(void) {
    return ax_safe_area_insets().top;
}


CGFloat ax_safe_area_insets_left(void) {
    return ax_safe_area_insets().left;
}


CGFloat ax_safe_area_insets_bottom(void) {
    return ax_safe_area_insets().bottom;
}


CGFloat ax_safe_area_insets_right(void) {
    return ax_safe_area_insets().right;
}


UIEdgeInsets ax_screen_padding_insets(void) {
    if ([UIView instancesRespondToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets insets = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
            if (insets.top <= 40.0f) {
                insets.top = 0.0f;
            }
            return insets;
        }
    }
    return UIEdgeInsetsZero;
}


CGFloat ax_screen_adaptive_float(CGFloat floatValue) {
    return ax_screen_adaptive_float_with_padding(floatValue, 0.0f);
}


CGFloat ax_screen_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding) {
    CGFloat currentScreenWidth = MIN(ax_screen_width(), ax_screen_height()) - padding;
    CGFloat standardScreenWidth = 375.0f - padding;
    return floorf(floatValue / standardScreenWidth * currentScreenWidth);
}


CGPoint ax_screen_adaptive_point(CGPoint pointValue) {
    return CGPointMake(ax_screen_adaptive_float(pointValue.x), ax_screen_adaptive_float(pointValue.y));
}


CGSize ax_screen_adaptive_size(CGSize sizeValue) {
    return CGSizeMake(ax_screen_adaptive_float(sizeValue.width), ax_screen_adaptive_float(sizeValue.height));
}


CGRect ax_screen_adaptive_rect(CGRect rectValue) {
    return CGRectMake(ax_screen_adaptive_float(rectValue.origin.x), ax_screen_adaptive_float(rectValue.origin.y), ax_screen_adaptive_float(rectValue.size.width), ax_screen_adaptive_float(rectValue.size.height));
}


CGFloat ax_screen_vertical_adaptive_float_with_padding(CGFloat floatValue, CGFloat padding) {
    CGFloat currentScreenHeight = MAX(ax_screen_width(), ax_screen_height()) - padding;
    CGFloat standardScreenHeight = 667.0f - padding;
    return floorf(floatValue / standardScreenHeight * currentScreenHeight);
}

