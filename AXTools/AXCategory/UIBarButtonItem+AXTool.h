//
//  UIBarButtonItem+AXTool.h
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AXTool)

+ (UIBarButtonItem *)ax_itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
/**
 封装Button作为一个item,并监听事件 图片和高亮图片
 */
+ (UIBarButtonItem *)ax_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIBarButtonItem *)ax_itemWithImage:(UIImage *)image title:(NSString *)title Target:(id)target action:(SEL)action;
/**
 封装Button作为一个item,-> 图片,文字, 监听事件
 */
+ (UIBarButtonItem *)ax_itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title;

/**
 封装Button作为一个item ->右返回按钮 图片,文字, 监听事件
 */
+ (UIBarButtonItem *)ax_itemRightWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title;

/**封装Button封装一个item,并监听事件*/
+ (UIBarButtonItem *)ax_itemWithNormalImage:(NSString *)normal disabledImage:(NSString *)disabled title:(NSString *)title  target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)ax_itemRightWithTitle:(NSString *)title normalImage:(NSString *)normalImage  selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

@end
