
//
//  MBProgressHUD+AX.h
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (AX)

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showUpLoadMessage:(NSString *)message;

+ (MBProgressHUD *)showUpLoadMessage:(NSString *)message toView:(UIView *)view;


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
+ (void)showSuccess:(NSString *)success completed:(void(^)(void))completed;
/**
 * 显示文字,不需要图片
 */
+ (void)showTitle:(NSString *)title;

@end
