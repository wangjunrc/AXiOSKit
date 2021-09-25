//
//  UIViewController+AXPhoto.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/12.
//

#import "UIViewController+AXPhoto.h"
#import <objc/runtime.h>
#import "UIViewController+AXKit.h"
#import <objc/runtime.h>
#import "AXiOSKit.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/Photos.h>
#import "AXDeviceFunctionDisableViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, copy)CameraEditBlock cameraEditBlock;

@property(nonatomic, copy)AXImagePickerInfoBlock imagePickerInfoBlock;

@end

@implementation UIViewController (AXPhoto)

/**
 *选择照片(相册或者拍照)含有编辑的样式
 *@param edit  是否编辑
 *@param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    [self  ax_showCameraWithEditing:edit showiPadView:nil block:block];
}

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
        [strongSelf ax_showCameraEdit:edit];
    }]];
    
    // 相册
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.FromPhotoAlbum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ax_showPhotoLibraryWithEdit:edit];
    }]];
    
    [self _alert:alert addPadView:iPadView];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)_alert:(UIAlertController * )alert addPadView:(UIView*)iPadView {
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect = iPadView.bounds;
    }
}

/// 打开相册
-(void)ax_showPhotoLibraryInfo:(AXImagePickerInfoBlock )infoBlock {
    self.imagePickerInfoBlock = infoBlock;
    [self ax_showPhotoLibraryWithEdit:NO];
}

-(void)ax_showCameraInfo:(AXImagePickerInfoBlock )infoBlock{
    self.imagePickerInfoBlock = infoBlock;
    [self ax_showCameraEdit:NO];
}

-(void)ax_showCameraEdit:(BOOL )edit {
    
    //设备是否有拍照功能支持拍照
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        // 设备不支持拍照
        AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotSupport];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
            
            // 设备未授权拍照
            AXDeviceFunctionDisableViewController *vc = [AXDeviceFunctionDisableViewController.alloc initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotAuthorize];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = edit;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}



-(void)ax_showPhotoLibraryWithEdit:(BOOL )edit {
    
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
        
        if (self.imagePickerInfoBlock) {
            self.imagePickerInfoBlock(info);
        }
    });
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 分类重写 set get 方法

- (void)setCameraEditBlock:(CameraEditBlock)cameraEditBlock{
    objc_setAssociatedObject(self, @selector(cameraEditBlock),cameraEditBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CameraEditBlock)cameraEditBlock{
    return objc_getAssociatedObject(self,@selector(cameraEditBlock));
}

- (void)setImagePickerInfoBlock:(AXImagePickerInfoBlock)imagePickerInfoBlock {
    objc_setAssociatedObject(self, @selector(imagePickerInfoBlock),imagePickerInfoBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (AXImagePickerInfoBlock)imagePickerInfoBlock {
    return objc_getAssociatedObject(self,@selector(imagePickerInfoBlock));
}


@end


