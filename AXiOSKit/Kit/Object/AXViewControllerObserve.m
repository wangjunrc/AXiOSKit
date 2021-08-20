//
//  AXViewControllerObserve.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//

#import "AXViewControllerObserve.h"
#import "UIViewController+AXKit.h"
#import <objc/runtime.h>
#import <AVFoundation/AVCaptureDevice.h>
/// 获得相机 相册权限
#import <Photos/PHPhotoLibrary.h>
#import "AXDeviceFunctionDisableViewController.h"
#import "NSObject+AXAssistant.h"
typedef void(^MediaReslutBlock)(AXMediaResult *result);

@interface AXViewControllerObserve ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, weak,readwrite) UIViewController *viewController;

@property (nonatomic, copy)MediaReslutBlock reslutBlock;

@end

@implementation AXViewControllerObserve

- (instancetype)initWithObserve:(UIViewController *)viewController{
    if (self = [self init]) {
        self.viewController = viewController;
    }
    return self;
}


- (AXViewControllerObserve *(^)(void(^)(void)))isPushed {
        __weak typeof(self) weakSelf = self;
        return ^AXViewControllerObserve *(void (^isPushed)(void)) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            /// firstObject!=self 表示被push的
            if (isPushed &&
                strongSelf.viewController.navigationController &&
                ![strongSelf.viewController.navigationController.viewControllers.firstObject isEqual:strongSelf.viewController]){
                isPushed();
            }
            return strongSelf;
        };
}
- (AXViewControllerObserve *(^)(void(^)(void)))isPresented {
        __weak typeof(self) weakSelf = self;
    
    __strong typeof(self.viewController) weakVC = self.viewController;
        return ^AXViewControllerObserve *(void (^isPresented)(void)) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            __strong typeof(weakVC) strongVC = weakVC;
            if (isPresented){
                /// iOS13之前,没有强制设置 modalPresentationStyle 父presentingViewController
                if (strongSelf.viewController.modalPresentationStyle != UIModalPresentationFullScreen && strongSelf.viewController.presentingViewController) {
                    isPresented();
                }else{
                    /// presentationController 转场动画VC 会强引用
//                   __weak Class aCla =  NSClassFromString(@"_UIFullscreenPresentationController");
//                    if ([strongVC.presentationController isKindOfClass:aCla]) {
//                        isPresented();
//                    };
                    if (!strongSelf.viewController.navigationController) {
                        isPresented();
                    }
                }

            }
            return strongSelf;
        };
}

-(void)setHiddenNavigationBar:(BOOL)hiddenNavigationBar {
    _hiddenNavigationBar = hiddenNavigationBar;
//    if (hiddenNavigationBar) {
//        // 设置导航控制器的代理为self
//        self.viewController.navigationController.delegate = self;
//        // 必须设置,不然返回手势失效
//        self.viewController.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }else{
//        self.viewController.navigationController.delegate = nil;
//        self.viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
    
    [self.viewController.navigationController setNavigationBarHidden:hiddenNavigationBar animated:NO];
    if (hiddenNavigationBar) {
        self.viewController.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
/// UINavigationControllerDelegate
//将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL hidden = [viewController isKindOfClass:self.viewController.class];
    hidden = hidden&&self.isHiddenNavigationBar;
    [self.viewController.navigationController setNavigationBarHidden:hidden animated:YES];
    /// 处理一下 viewController 内容含有 scrollView ,在viewController中需要偏移一下
    if (hidden) {
        [self.viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:UIScrollView.class]) {
                UIScrollView *scrollView = (UIScrollView *)obj;
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                *stop = YES;
            }
        }];
    }
    
}



/// 选择照片(相册或者拍照)
/// @param config 配置
/// @param block 回调
- (void)showCameraWithConfig:(AXMediaConfig *)config
                          block:(void(^)(AXMediaResult *result))block {
    [self showCameraWithConfig:config showiPadView:nil block:block];
}


#pragma mark - iPad alert

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 
 @param edit 是否编辑
 @param iPadView iPad 需要显传入显示的view
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)showCameraWithConfig:(AXMediaConfig *)config
                showiPadView:(UIView *)iPadView
                       block:(void(^)(AXMediaResult *result))block{
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
//    [self.viewController presentViewController:alert animated:YES completion:nil];
    [self.viewController ax_showVC:alert];
}

-(void)_alertToCamera:(AXMediaConfig *)config {
    
    //设备是否有拍照功能支持拍照
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        // 设备不支持拍照
        AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotSupport];
        
        [self.viewController presentViewController:vc animated:YES completion:nil];
        
    }else{
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
            // 设备未授权拍照
            
            AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeCamera disableType:AXDeviceFunctionDisableTypeNotAuthorize];
            [self.viewController ax_showVC:vc];
        }else {
            [self _pickerController:UIImagePickerControllerSourceTypeCamera config:config];
        }
    }
}

-(void)_alertToPhotoLibrary:(AXMediaConfig *)config {
    
    //是否有相册功能,iTouch 是没有此功能的
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeAlbumRead disableType:AXDeviceFunctionDisableTypeNotSupport];
        
        [self.viewController ax_showVC:vc];
        
    }else{
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
            
            // 设备未授权拍照
            AXDeviceFunctionDisableViewController *vc = [[AXDeviceFunctionDisableViewController alloc]initWithType:AXDeviceFunctionTypeAlbumRead disableType:AXDeviceFunctionDisableTypeNotAuthorize];
            
            [self.viewController ax_showVC:vc];
            
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
        picker.allowsEditing = config.editing;
        if (config.mediaTypes) {
            picker.mediaTypes = config.mediaTypes;
        }
    }
    [self.viewController ax_showVC:picker];
    
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


@end
