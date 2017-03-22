//
//  UIViewController+AXAlert.h
//  AXTools
//
//  Created by Mole Developer on 16/9/19.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AXAlert)

/**
 *选择照片(相册或者拍照)含有编辑的样式
 @param edit  是否编辑
 @param block originalImage原图  editedImage编辑后图片
 */
-(void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;


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
-(void)ax_showAlertByTitle:(NSString *)title certain:(void(^)())certain;

/**
 * 有确定,取消 ,确定按钮文字
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certainTitle:(NSString *)certainTitle certain:(void(^)())certain cancel:(void(^)())cancel;


/**
 * Alert 有确定和取消
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certain:(void(^)())certain cancel:(void(^)())cancel;

/**
 * Sheet  没有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain;

/**
 * Sheet 有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain  cancel:(void(^)( ))cancel;


/**
 * Sheet 退出登录
 */
-(void)ax_showSheeExitLogin:(void(^)())certain;

/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message certain:(void(^)( NSString *text))certain cancel:(void(^)())cancel;



/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTF:(UITextField *)textF Title:(NSString *)title message:(NSString *)message certain:(void(^)(UITextField *textF))certain cancel:(void(^)())cancel;

/**
 * 流量网络下载,提示
 */
-(void)ax_showNetDownloadGo:(void(^)())certain cancel:(void(^)())cancel;
@end
