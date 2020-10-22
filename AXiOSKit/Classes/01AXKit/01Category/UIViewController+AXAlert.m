//
//  UIViewController+AXAlert.m
//  AXiOSKit
//
//  Created by liuweixing on 16/9/19.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIViewController+AXAlert.h"
#import <objc/runtime.h>
#import "UIViewController+AXKit.h"
#import <objc/runtime.h>
#import "AXiOSKit.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/Photos.h>
#import "AXDeviceFunctionDisableViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

typedef void(^CameraEditBlock)(UIImage *originalImage,UIImage *editedImage);

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, copy)CameraEditBlock cameraEditBlock;

@end


@implementation UIViewController (AXAlert)

#pragma mark - Sheet


/**
 *选择照片(相册或者拍照)含有编辑的样式
 *@param edit  是否编辑
 *@param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    [self  ax_showCameraWithEditing:edit showiPadView:nil block:block];
}

/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm];
    
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
}

/**
 * Sheet 退出登录
 */
- (void)ax_showSheeLogout:(void(^)(void))confirm{
    [self ax_showSheeLogoutByPadView:nil confirm:confirm];
}

#pragma mark - Alert

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertArrayByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
    
}


/**
 * 只有确定,没有回调
 */
- (void)ax_showAlertByTitle:(NSString *)title{
    [self ax_showAlertByTitle:title confirm:nil];
}


/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/*=======================================*/

/**
 * 有确定,取消 ,确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(confirmTitle )style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * 有确定,取消
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByTitle:title message:message confirmTitle:AXKitLocalizedString(@"ax.confirm") confirm:confirm cancel:cancel];
}

/**
 * 流量网络下载,提示
 */
- (void)ax_showNetDownloadGo:(void(^)(void))go cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AXKitLocalizedString(@"当前网络为数据流量") message:AXKitLocalizedString(@"是否取消下载") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"继续下载") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (go) {
            go();
        }
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"取消下载") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
- (void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)( NSString *text))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    

    UITextField * textF=nil;
    __block typeof(textF)weaktextF = textF;

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        weaktextF = textField;
        textField.placeholder = message;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF.text);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTF:(UITextField *)textF title:(NSString *)title message:(NSString *)message confirm:(void(^)( UITextField *textF))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
     __block typeof(textF)weaktextF = textF;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = textF.placeholder;
        textField.keyboardType = textF.keyboardType;
        textField.secureTextEntry = textF.secureTextEntry;

        weaktextF = textField;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.confirm") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - iPad alert


/**
 *选择照片(相册或者拍照)含有编辑的样式
 *@param edit  是否编辑
 *@param block originalImage原图  editedImage编辑后图片
 */

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 
 @param edit 是否编辑
 @param iPadView iPad 需要显传入显示的view
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit showiPadView:(UIView *)iPadView block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    self.cameraEditBlock = block;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:nil]];
    __weak typeof(self) weakSelf = self;
    // 拍照
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.TakePhoto") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf __alertToCamera:edit];
    }]];
    
    // 相册
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.FromPhotoAlbum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf __alertToPhotoLibrary:edit];
    }]];
    
    
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect =iPadView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)__alertToCamera:(BOOL )edit {
    
    //设备是否有拍照功能支持拍照
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        // 设备不支持拍照
        AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotSupport];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
            
            // 设备未授权拍照
            
            AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotAuthorize];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        }else {
            
            //做你想做的（可以去打开设置的路径）
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = edit;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

-(void)__alertToPhotoLibrary:(BOOL )edit {
    
    //是否有相册功能,iTouch 是没有此功能的
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeAlbumRead disableType:AXDeviceFunctionDisableTypeNotSupport];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
            
            // 设备未授权拍照
            AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeAlbumRead disableType:AXDeviceFunctionDisableTypeNotAuthorize];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        }else {
            
            //图片列表方式
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //  显示 图片,视频
            picker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString*)kUTTypeMovie];
            //  显示 图片
//            picker.mediaTypes = @[(NSString *)kUTTypeImage];
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = edit;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
}

/**
 * UIImagePickerControllerDelegate
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    /**
    NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
    NSString *const  UIImagePickerControllerOriginalImage ;原始图片
    NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
    NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
    NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
    NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
    NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     */
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //原图
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        
        //编辑后的图片
        UIImage* editedImage = info[UIImagePickerControllerEditedImage];
        // 原件的URL
        NSURL *referenceURL = info[UIImagePickerControllerReferenceURL];
        NSLog(@"referenceURL %@",referenceURL);
        /// 媒体的URL 只有视频才有
        NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
        NSLog(@"mediaURL %@",mediaURL);
        
        if (self.cameraEditBlock) {
            self.cameraEditBlock(originalImage,editedImage);
        }
    });
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
    
    
}

#pragma mark - Sheet

/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm{
    
    [self ax_showSheetByiPadView:iPadView title:title message:message actionArray:actionArray confirm:confirm cancel:nil];
    
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    
    for (NSInteger index=0; index<actionArray.count; index++) {
        
        NSString *title = actionArray[index];
        
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm(index);
            }
        }]];
    }
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect = iPadView.bounds;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
 * Sheet 退出登录 兼容iPad需要传入view
 */
- (void)ax_showSheeLogoutByPadView:(UIView *)iPadView confirm:(void(^)(void))confirm{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:AXKitLocalizedString(@"ax.logOut.message") preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.logOut") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect =iPadView.bounds;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancel) {
            cancel();
        }
        
    }]];
    
    
    for (NSInteger index=0; index<actionArray.count; index++) {
        
        NSString *title = actionArray[index];
        
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (confirm) {
                confirm(index);
            }
            
        }]];
    }
    
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect = iPadView.bounds;
    }
    
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
