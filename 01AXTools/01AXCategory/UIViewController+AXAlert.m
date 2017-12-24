//
//  UIViewController+AXAlert.m
//  AXTools
//
//  Created by Mole Developer on 16/9/19.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UIViewController+AXAlert.h"
#import <objc/runtime.h>
#import "UIViewController+AXTool.h"
typedef void(^CameraEditBlock)(UIImage *originalImage,UIImage *editedImage);

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)CameraEditBlock cameraEditBlock;

@end

@implementation UIViewController (AXAlert)

#pragma mark - Sheet


/**
 *选择照片(相册或者拍照)含有编辑的样式
 *@param edit  是否编辑
 *@param block originalImage原图  editedImage编辑后图片
 */
-(void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    [self  ax_showCameraWithEditing:edit showiPadView:nil block:block];
}

/**
 * Sheet  没有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray certain:certain];
    
}

/**
 * Sheet 有取消回调
 */
-(void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain cancel:(void(^)(void))cancel{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray certain:certain cancel:cancel];
}

/**
 * Sheet 退出登录
 */
-(void)ax_showSheeLogout:(void(^)(void))certain{
    [self ax_showSheeLogoutByPadView:nil certain:certain];
}

#pragma mark - Alert

/**
 * 只有确定,没有回调
 */
-(void)ax_showAlertByTitle:(NSString *)title{
    [self ax_showAlertByTitle:title certain:nil];
}


/**
 * 有确定和回调
 */
-(void)ax_showAlertByTitle:(NSString *)title certain:(void(^)(void))certain{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"知道了") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/*=======================================*/

/**
 * 有确定,取消 ,确定按钮文字
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certainTitle:(NSString *)certainTitle certain:(void(^)(void))certain cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(certainTitle )style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain();
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * 有确定,取消
 */
-(void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message certain:(void(^)(void))certain cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByTitle:title message:message certainTitle:AXLocalizedString(@"确定") certain:certain cancel:cancel];
}

/**
 * 流量网络下载,提示
 */
-(void)ax_showNetDownloadGo:(void(^)(void))go cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AXLocalizedString(@"当前网络为数据流量") message:AXLocalizedString(@"是否取消下载") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"继续下载") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (go) {
            go();
        }
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消下载") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Alert+UITextField
/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message certain:(void(^)( NSString *text))certain cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    

    UITextField * textF=nil;
    __block typeof(textF)weaktextF = textF;

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        weaktextF = textField;
        textField.placeholder = message;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(weaktextF.text);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * Alert含有输入文本框
 */
-(void)ax_showAlertTF:(UITextField *)textF Title:(NSString *)title message:(NSString *)message certain:(void(^)( UITextField *textF))certain cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
     __block typeof(textF)weaktextF = textF;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = textF.placeholder;
        textField.keyboardType = textF.keyboardType;
        textField.secureTextEntry = textF.secureTextEntry;

        weaktextF = textField;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"确定") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(weaktextF);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark分类重写 set get 方法
/**
 * cameraEditBlock set方法
 */
- (void)setCameraEditBlock:(CameraEditBlock)cameraEditBlock{
    objc_setAssociatedObject(self, @selector(cameraEditBlock),cameraEditBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 * cameraEditBlock get方法
 */
- (CameraEditBlock)cameraEditBlock{
    return objc_getAssociatedObject(self,@selector(cameraEditBlock));
}

@end
