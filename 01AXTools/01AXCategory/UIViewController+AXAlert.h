//
//  UIViewController+AXAlert.h
//  AXTools
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
-(void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;

/**
 * Sheet  没有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain;

/**
 * Sheet 有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain  cancel:(void(^)(void))cancel;

/**
 * Sheet 退出登录
 */
-(void)ax_showSheeLogout:(void(^)(void))certain;


#pragma mark - Alert


/**
 * Alert 只有确定,没有回调
 */
-(void)ax_showAlertByTitle:(NSString *)title;

/**
 * Alert 只有确回调
 */
/**
 * 有确定和回调
 */
-(void)ax_showAlertByTitle:(NSString *)title certain:(void(^)(void))certain;

/**
 * 有确定,取消 ,确定按钮文字
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certainTitle:(NSString *)certainTitle certain:(void(^)(void))certain cancel:(void(^)(void))cancel;


/**
 * Alert 有确定和取消
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certain:(void(^)(void))certain cancel:(void(^)(void))cancel;


/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message certain:(void(^)( NSString *text))certain cancel:(void(^)(void))cancel;

/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTF:(UITextField *)textF Title:(NSString *)title message:(NSString *)message certain:(void(^)(UITextField *textF))certain cancel:(void(^)(void))cancel;

/**
 * 流量网络下载,提示
 */
-(void)ax_showNetDownloadGo:(void(^)(void))certain cancel:(void(^)(void))cancel;

@end
