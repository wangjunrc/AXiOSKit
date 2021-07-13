//
//  _13WebpViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_13AnimatedImageVC.h"
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>
#import <AXiOSKit/AXiOSKit.h>
@import AssetsLibrary;
#import <Photos/Photos.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <SDWebImage/SDWebImage.h>
#import "AXUserSwiftImport.h"
#import <MobileCoreServices/UTCoreTypes.h>

@import YYImage;


@interface _13AnimatedImageVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>


@property(nonatomic,strong)NSData *gifData;

@end

@implementation _13AnimatedImageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self _show_gif];
    [self _show_webp];
    [self _show_apng];
    [self _saveGIF];
    [self _find_gif];
    [self _lastLoadBottomAttribute];
}


- (NSData *)gifData {
    if (!_gifData) {
        _gifData = [NSData ax_mainBundleDataName:@"Image.bundle/gif_test_2.gif"];
    }
    return _gifData;
}



-(void)_show_apng {
    
    [self _dividerLabel:@"显示png"];
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"UIImageView apng,无效"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
//        imageView.image = [UIImage imageNamed:@"apng_elephant"];
        imageView.image = [UIImage imageWithData:[NSData ax_mainBundleDataName:@"Image.bundle/apng_elephant.png"]];
        
    }
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"YYAnimatedImageView apng"];
        YYImage *image = [YYImage imageNamed:@"Image.bundle/apng_elephant"];
        UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.backgroundColor = UIColor.redColor;
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
    }
    
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"FLAnimatedImageView,没有apng方法,无效"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        /// 本地 data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Image.bundle/apng_elephant.png" ofType:nil];
        if (path) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
            imageView.animatedImage = image;
        }
    }
}


-(void )_show_webp{
    
    [self _titlelabel:@"UIImageView显示webp,sd_imageWithWebPData"];
    UIImageView *webpImv  = [[UIImageView alloc]init];
    [self _loadCenterXWithView:webpImv size:CGSizeMake(100, 100)];
    webpImv.backgroundColor = UIColor.redColor;
    /// webp 放在一个bundle 中,不然无法加载
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_webp" ofType:@"webp" inDirectory:@"webp.bundle"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSData *data =   [NSData ax_mainBundleDataName:@"Image.bundle/test_webp.webp"];
    ///根据不同的URL显示webp
    UIImage *img = [UIImage sd_imageWithWebPData:data];
    webpImv.image = img;
    webpImv.contentMode = UIViewContentModeScaleAspectFit;
}


-(void)_show_gif{
    
    [self _dividerLabel:@"显示gif"];
    
    {
        [self _titlelabel:@"UIImageView显示gif,sd_imageWithWebPData"];
        
        UIImageView *gifImv  = [[UIImageView alloc]init];
        [self _loadCenterXWithView:gifImv size:CGSizeMake(100, 100)];
        UIImage *img = [UIImage sd_imageWithGIFData:self.gifData];
        gifImv.image = img;
        gifImv.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    {
        [self _titlelabel:@"SDAnimatedImageView"];
        
        SDAnimatedImageView *imageView = [SDAnimatedImageView.alloc init];
        imageView.image = [SDAnimatedImage  imageWithData:self.gifData];
        
        /// 这2句,同时控制是否重复
        imageView.shouldCustomLoopCount = YES;
        imageView.animationRepeatCount = 0;
        
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
    }
    
    [self _dividerLabel:@"FLAnimatedImageView-animatedImage"];
    
    {
        [self _titlelabel:@"FLAnimatedImageView显示URL ,FLAnimatedImage,本地path转data"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:self.gifData];
        imageView.animatedImage = animatedImage1;
    }
    
    {
        [self _titlelabel:@"FLAnimatedImageView,sd_setImageWithURL"];
        
        /// 4.4.0 版本之后换了另外一种方式， 新增加了 FLAnimatedImageView 来实现动态图片的展示，继承自 UIImageView
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL ax_mainBundleURLName:@"Image.bundle/gif_test_2.gif"]];
        
    }
    
    
    {
        [self _titlelabel:@"FLAnimatedImageView-sd_setImageWithURLf"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSURL *URL = [NSURL URLWithString:@"http://img.autohome.com.cn/album/2009/3/16/52bba7e6-1b9e-4ebb-b887-56b41be4ba2a.gif"];
        [imageView sd_setImageWithURL:URL];
    }
    
}


-(void)_find_gif {
    
    [self _titlelabel:@"相册中获得gif"];
    
    UIImageView *gifImv  = [[UIImageView alloc]init];
    [self _loadCenterXWithView:gifImv size:CGSizeMake(100, 100)];
    
    gifImv.contentMode = UIViewContentModeScaleAspectFit;
    
    @weakify(self)
    [self _buttonTitle:@"打开相册" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
//        [self ax_showCameraWithEditing:NO block:^(UIImage *originalImage, UIImage *editedImage) {
//            UIImage *img = [UIImage sd_imageWithGIFData:UIImagePNGRepresentation(originalImage)];
//            gifImv.image = img;
//
//        }];
        
//        [self ax_showPhotoLibraryInfo:^(NSDictionary<UIImagePickerControllerInfoKey,id> * _Nonnull info) {
//
//
//            if(@available(iOS 11.0, *)) {
//
//                   PHAsset *phAss = [info valueForKey:UIImagePickerControllerPHAsset];
//
//                   PHImageRequestOptions *options = [PHImageRequestOptions new];
//
//                   options.resizeMode = PHImageRequestOptionsResizeModeFast;
//
//             // 同步获得图片, 只会返回1张图片
//                   options.synchronous=YES;
//
//
//                   PHCachingImageManager *mager = [[PHCachingImageManager alloc]init];
//
//
//                [mager requestImageDataForAsset:phAss options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//
//
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSLog(@"imageData=%@",imageData);
////                        if (imageData) {
////                            UIImage *img = [UIImage sd_imageWithGIFData:imageData];
////                            gifImv.image = img;
////                        }
//                    });
//
//
//
//                }];
//
//           }
//
//        }];
        
        
        //图片列表方式
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //  显示 图片,视频
        picker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString*)kUTTypeMovie];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }];
}

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
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(@available(iOS 11.0, *)) {

               PHAsset *phAss = [info valueForKey:UIImagePickerControllerPHAsset];
          
               PHImageRequestOptions *options = [PHImageRequestOptions new];

               options.resizeMode = PHImageRequestOptionsResizeModeFast;
            
         // 同步获得图片, 只会返回1张图片
               options.synchronous=YES;
            
            
            [PHCachingImageManager.defaultManager requestImageForAsset:phAss targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                 
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"imageData=%@",imageData);
////                        if (imageData) {
////                            UIImage *img = [UIImage sd_imageWithGIFData:imageData];
////                            gifImv.image = img;
////                        }
//                });
                
            }];
            
//            [PHImageManager.defaultManager requestImageDataForAsset:phAss options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"imageData=%@",imageData);
////                        if (imageData) {
////                            UIImage *img = [UIImage sd_imageWithGIFData:imageData];
////                            gifImv.image = img;
////                        }
//                });
//
//
//
//            }];

       }
        
//    });
    
}


/// 保存GIF到相册
-(void)_saveGIF{
    ax_weakify(self);
    [self _buttonTitle:@"保存到相册"  handler:^(UIButton * _Nonnull btn) {
        ax_strongify(self);
        [self.gifData ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [self ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
            
        }];
    }];
    
}


- (void)dealloc{
    axLong_dealloc
}

@end
