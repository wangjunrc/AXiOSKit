//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showUpLoadMessage:(NSString *)message;




+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showWarning:(NSString *)warning;
+ (void)showWarning:(NSString *)warning toView:(UIView *)view;



+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

/**
 * 显示成功,含有回调
 */
+ (void)showSuccess:(NSString *)success completed:(void(^)())completed;
/**
 * 显示文字,不需要图片
 */
+ (void)showTitle:(NSString *)title;

@end
