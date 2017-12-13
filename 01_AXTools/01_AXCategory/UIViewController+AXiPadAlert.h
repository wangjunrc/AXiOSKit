//
//  UIViewController+AXiPadAlert.h
//  BigApple
//
//  Created by liuweixing on 2017/4/15.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AXiPadAlert)

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
-(void)ax_showCameraWithEditing:(BOOL)edit showiPadView:(UIView *)iPadView block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;

/**
 Sheet  没有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param certain 选中按钮回调
 */
-(void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain;

/**
 Sheet 有取消回调

 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionArray 其他按钮文字数组
 @param certain 选中按钮回调
 @param cancel 取消回调
 */
-(void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain cancel:(void(^)(void))cancel;

/**
 Sheet 退出登录

 @param iPadView 兼容iPad需要传入view
 @param certain 确定回调
 */
-(void)ax_showSheeLogoutByPadView:(UIView *)iPadView certain:(void(^)(void))certain;


@end
