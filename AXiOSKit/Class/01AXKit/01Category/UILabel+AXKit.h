//
//  UILabel+AXKit.h
//  
//
//  Created by liuweixing on 15/10/27.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AXKit)

/**
 * 是否可以长按显示复制Menu
 */
@property (nonatomic, assign) BOOL ax_longPressCopyMenu;

/**
 设置 电话 含有下划线,并可以点击打电话
 */
- (void)ax_setPhoneCall;


- (void)ax_setTextWithLinkAttribute:(NSString *)text;

@end
