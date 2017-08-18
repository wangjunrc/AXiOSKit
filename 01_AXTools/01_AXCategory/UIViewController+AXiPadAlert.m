//
//  UIViewController+AXiPadAlert.m
//  BigApple
//
//  Created by liuweixing on 2017/4/15.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIViewController+AXiPadAlert.h"
#import <objc/runtime.h>
#import "AXToolsHeader.h"
typedef void(^CameraEditBlock)(UIImage *originalImage,UIImage *editedImage);

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)CameraEditBlock cameraEditBlock;

@end



@implementation UIViewController (AXiPadAlert)

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
-(void)ax_showCameraWithEditing:(BOOL)edit showiPadView:(UIView *)iPadView block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    self.cameraEditBlock = block;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){ //支持拍照
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = edit;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"从相册中选择") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){//图片列表方式
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = edit;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }]];
    
    if (iPadView != nil) {
        
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect =iPadView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
 * UIImagePickerControllerDelegate
 */
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //原图
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        
        //编辑后的图片
        UIImage* editedImage = info[UIImagePickerControllerEditedImage];
        
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
-(void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain{
    [self ax_showSheetByiPadView:iPadView title:title message:message actionArray:actionArray certain:certain cancel:nil];

}

/**
 * Sheet 有取消回调
 */
-(void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain cancel:(void(^)( ))cancel{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    
    for (NSInteger index=0; index<actionArray.count; index++) {
        
        NSString *title = actionArray[index];
        
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (certain) {
                certain(index);
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
-(void)ax_showSheeLogoutByPadView:(UIView *)iPadView certain:(void(^)())certain{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:AXLocalizedString(@"退出后不会删除任何历史数据,下次登录依然可以使用本账号") preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXLocalizedString(@"退出登录") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(index);
        }
    }]];
    
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect =iPadView.bounds;
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
