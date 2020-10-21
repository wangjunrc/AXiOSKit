//
//  UIViewController+AXMedia.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/23.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "UIViewController+AXMedia.h"

#import "UIViewController+AXKit.h"
#import <objc/runtime.h>
#import <AVFoundation/AVCaptureDevice.h>
/// 获得相机 相册权限
#import <Photos/PHPhotoLibrary.h>
#import "AXDeviceFunctionDisableViewController.h"

typedef void(^MediaReslutBlock)(AXMediaResult *result);

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, copy)MediaReslutBlock reslutBlock;

@end


@implementation UIViewController (AXMedia)

/// 选择照片(相册或者拍照)
/// @param config 配置
/// @param block 回调
- (void)ax_showCameraWithConfig:(AXMediaConfig *)config
                          block:(void(^)(AXMediaResult *result))block {
    [self ax_showCameraWithConfig:config showiPadView:nil block:block];
}


#pragma mark - iPad alert

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 */
- (void)ax_showCameraWithConfig:(AXMediaConfig *)config showiPadView:(UIView *)iPadView block:(void(^)(AXMediaResult *result))block{
    self.reslutBlock = block;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:nil]];
    __weak typeof(self) weakSelf = self;
    // 拍照
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.TakePhoto") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _alertToCamera:config];
    }]];
    
    // 相册
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.FromPhotoAlbum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _alertToPhotoLibrary:config];
    }]];
    
    
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect =iPadView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)_alertToCamera:(AXMediaConfig *)config {
    
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
            [self _pickerController:UIImagePickerControllerSourceTypeCamera config:config];
        }
    }
}

-(void)_alertToPhotoLibrary:(AXMediaConfig *)config {
    
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
            [self _pickerController:UIImagePickerControllerSourceTypePhotoLibrary config:config];
        }
    }
    
}

-(void )_pickerController:(UIImagePickerControllerSourceType)sourceType config:(AXMediaConfig *)config{
  
    //图片列表方式
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    
    if (config) {
        picker.allowsEditing = config.isEditing;
        if (config.mediaTypes) {
            picker.mediaTypes = config.mediaTypes;
        }
    }
    [self presentViewController:picker animated:YES completion:nil];
    
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
        /// 媒体的URL 只有视频才有
        NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
        
        AXMediaResult *result = AXMediaResult.alloc.init;
        result.originalImage =originalImage;
        result.editedImage =editedImage;
        result.referenceURL =referenceURL;
        result.mediaURL =mediaURL;
        
        if (self.reslutBlock) {
            self.reslutBlock(result);
        }
    });
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark分类重写 set get 方法

- (MediaReslutBlock)reslutBlock{
    return objc_getAssociatedObject(self,@selector(reslutBlock));
}
- (void)setReslutBlock:(MediaReslutBlock)reslutBlock{
    objc_setAssociatedObject(self, @selector(reslutBlock),reslutBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
