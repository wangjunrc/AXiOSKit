//
//  UIViewController+AXPhoto.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 图片信息
typedef void(^AXImagePickerInfoBlock)(NSDictionary<UIImagePickerControllerInfoKey, id> *info);

typedef void(^CameraEditBlock)(UIImage *originalImage,UIImage *editedImage);


@interface UIViewController (AXPhoto)

/**
 *选择照片(相册或者拍照)含有编辑的样式
 @param edit  是否编辑
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit
                           block:(void(^)(UIImage *originalImage,
                                          UIImage *editedImage))block;

/**
 选择照片(相册或者拍照)含有编辑的样式 兼容iPad 需要显传入显示的view iPhone可以不传
 
 @param edit 是否编辑
 @param iPadView iPad 需要显传入显示的view
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit
                    showiPadView:(UIView *)iPadView
                           block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;


/// 打开相册
-(void)ax_showPhotoLibraryInfo:(AXImagePickerInfoBlock )infoBlock;

@end

NS_ASSUME_NONNULL_END
