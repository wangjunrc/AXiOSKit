//
//  UIViewController+AXAlert.h
//  AXiOSKit
//
//  Created by liuweixing on 16/9/19.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (AXAlert)


#pragma mark - sheet


/**
 *选择照片(相册或者拍照)含有编辑的样式
 @param edit  是否编辑
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit
                           block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;



/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title
                    message:(NSString*)message
                actionArray:(NSArray <NSString*>*)actionArray
                    confirm:(void(^)(NSInteger index))confirm;

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title
                    message:(NSString*)message
                actionArray:(NSArray <NSString*>*)actionArray
                    confirm:(void(^)(NSInteger index))confirm
                     cancel:(void(^)(void))cancel;

/**
 * Sheet 退出登录
 */
- (void)ax_showSheeLogout:(void(^)(void))confirm;


#pragma mark - Alert


/**
 * Alert 只有确定,没有回调,只显示确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title;

/**
 * Alert 只有确回调
 */
/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title
                    confirm:(void(^)(void))confirm;

/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title
                    message:(NSString *)message
                    confirm:(void(^)(void))confirm;

/**
 * 有确定,取消 ,确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title
                    message:(NSString *)message
               confirmTitle:(NSString *)confirmTitle
                    confirm:(void(^)(void))confirm
                     cancel:(void(^)(void))cancel;


/**
 * Alert 有确定和取消
 */
- (void)ax_showAlertByTitle:(NSString *)title
                    message:(NSString *)message
                    confirm:(void(^)(void))confirm
                     cancel:(void(^)(void))cancel;


/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTFByTitle:(NSString *)title
                      message:(NSString *)message
                      confirm:(void(^)( NSString *text))confirm
                       cancel:(void(^)(void))cancel;

/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTF:(UITextField *)textF
                 title:(NSString *)title
               message:(NSString *)message
               confirm:(void(^)(UITextField *textF))confirm
                cancel:(void(^)(void))cancel;

/**
 * 流量网络下载,提示
 */
- (void)ax_showNetDownloadGo:(void(^)(void))confirm
                      cancel:(void(^)(void))cancel;

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertArrayByTitle:(NSString *)title
                         message:(NSString*)message
                     actionArray:(NSArray <NSString*>*)actionArray
                         confirm:(void(^)(NSInteger index))confirm
                          cancel:(void(^)(void))cancel;



/**
 * UIAlertControllerStyleActionSheet 样式的 兼容iPad时 需要显传入显示的view iPhone可以不传 或者直接调用 #import "UIViewController+AXAlert.h" 方法
 */


#pragma mark sheet

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 
 @param edit 是否编辑
 @param iPadView iPad 需要显传入显示的view
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit
                    showiPadView:(UIView *)iPadView
                           block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;

/**
 Sheet  没有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param confirm 选中按钮回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm;

/**
 Sheet 有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param confirm 选中按钮回调
 @param cancel 取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel;

/**
 Sheet 退出登录

 @param iPadView 兼容iPad需要传入view
 @param confirm 确定回调
 */
- (void)ax_showSheeLogoutByPadView:(UIView *)iPadView
                           confirm:(void(^)(void))confirm;

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel;

//========================iPad alert
#pragma mark - iPad alert

/**
 * UIAlertControllerStyleActionSheet 样式的 兼容iPad时 需要显传入显示的view iPhone可以不传 或者直接调用 #import "UIViewController+AXAlert.h" 方法
 */


#pragma mark sheet

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 
 @param edit 是否编辑
 @param iPadView iPad 需要显传入显示的view
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit
                    showiPadView:(UIView *)iPadView
                           block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;

/**
 Sheet  没有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param confirm 选中按钮回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm;

/**
 Sheet 有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param confirm 选中按钮回调
 @param cancel 取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel;

/**
 Sheet 退出登录

 @param iPadView 兼容iPad需要传入view
 @param confirm 确定回调
 */
- (void)ax_showSheeLogoutByPadView:(UIView *)iPadView
                           confirm:(void(^)(void))confirm;

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel;
@end
