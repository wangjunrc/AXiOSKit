//
//  _20iOS14ViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_20PhotoViewController.h"
#import <PhotosUI/PhotosUI.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "TZImagePickerController.h"


@interface _20PhotoViewController () <PHPickerViewControllerDelegate>

@property(strong, nonatomic) UIImageView *imageView;

@property(strong, nonatomic) FLAnimatedImageView *imageView2;

@property (nonatomic, strong) PHLivePhotoView *livePhotoView API_AVAILABLE(ios(9.1));

@end

@implementation _20PhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    __weak typeof(self) weakSelf = self;
    
    {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1028x1028"]];
        self.imageView.backgroundColor = UIColor.orangeColor;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100.0);
            make.height.mas_equalTo(100.0);
        }];
        self.bottomAttribute =  self.imageView.mas_bottom;
    }
    
    {
        
        self.imageView2 = [[FLAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"1029x1029"]];
        self.imageView2.backgroundColor = UIColor.redColor;
        self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.imageView2];
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100.0);
            make.height.mas_equalTo(100);
            
        }];
        self.bottomAttribute = self.imageView2 .mas_bottom;
    }
    
    
    if (@available(iOS 9.1, *)) {
        self.livePhotoView = [[PHLivePhotoView alloc] init];
        self.livePhotoView.backgroundColor = UIColor.greenColor;
        self.livePhotoView.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.livePhotoView];
        [self.livePhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo( self.bottomAttribute).mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100.0);
            make.height.mas_equalTo(100);
        }];
        self.bottomAttribute = self.livePhotoView .mas_bottom;
    }
    
    
    
    [self _buttonTitle:@"iOS14相册" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _iOS14Camera];
    }];
    
    
    [self _buttonTitle:@"PHPhotoLibrary-授权,不是全选,才会弹出" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (@available(iOS 14, *)) {
            [[PHPhotoLibrary sharedPhotoLibrary] presentLimitedLibraryPickerFromViewController:strongSelf];
        }
    }];
    
    
    
    [self _buttonTitle:@"TZImagePickerController" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf __TZImagePickerController:10];
    }];
    
    NSLog(@"kUTTypeQuickTimeMovie = %@", (NSString*)kUTTypeQuickTimeMovie);
    NSLog(@"kUTTypeImage = %@", (NSString *)kUTTypeImage);
    NSLog(@"kUTTypeJPEG = %@", (NSString *)kUTTypeJPEG);
    NSLog(@"kUTTypeGIF = %@", (NSString *)kUTTypeGIF);
    NSLog(@"kUTTypePNG = %@", (NSString *)kUTTypePNG);
    
    
    [self _buttonTitle:@"裁剪" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _cutPhoto];
    }];
    
    
    //    if (@available(iOS 9.1, *)) {
    //        [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"JPG"]],[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"mov"]]] placeholderImage:[UIImage imageNamed:@"1029x1029"] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
    //
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                if (livePhoto) {
    //                    NSLog(@"livePhoto222 = %@  info = %@",livePhoto,info);
    //                    self.livePhotoView.livePhoto = livePhoto;
    //                }
    //
    //
    //            });
    //
    //        }];
    //    } else {
    //        // Fallback on earlier versions
    //    }
    
    
    /// 底部约束
    [self _loadBottomAttribute];
}

- (void)_iOS14Camera{
    
    AXMediaConfig *config = AXMediaConfig.alloc.init;
    config.editing = NO;
    config.mediaTypes = @[AXMediaType.kUTTypeImage,AXMediaType.kUTTypeMovie];
    
    [self.ax_controllerObserve showCameraWithConfig:config block:^(AXMediaResult * _Nonnull result) {
        
    }];
    //    [self ax_showCameraWithConfig:config block:^(AXMediaResult * _Nonnull result) {
    //
    //    }];
    return;
    
    // 以下 API 仅为 iOS14 only
    //    if (@available(iOS 14, *)) {
    //        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
    //        ///imagesFilter 包含 livePhotosFilter
    //        //        configuration.filter = [PHPickerFilter imagesFilter]; // 可配置查询用户相册中文件的类型，支持三种
    //        //        configuration.filter = [PHPickerFilter livePhotosFilter];
    //
    //
    //        configuration.filter = [PHPickerFilter anyFilterMatchingSubfilters:@[
    //            [PHPickerFilter imagesFilter],
    //            [PHPickerFilter livePhotosFilter],
    //            [PHPickerFilter videosFilter]
    //        ]];
    //
    //
    //        configuration.selectionLimit = 0; // 默认为1，为0时表示可多选。
    //
    //        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
    //        picker.delegate = self;
    //        picker.view.backgroundColor = [UIColor whiteColor];//注意需要进行暗黑模式适配
    //        // picker vc，在选完图片后需要在回调中手动 dismiss
    //        [self presentViewController:picker animated:YES completion:^{
    //
    //        }];
    //    } else {
    //        // Fallback on earlier versions
    //    }
    
    
    
    //    _cutPhoto
}


-(void)__TZImagePickerController:(NSInteger )count{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];
    imagePickerVc. allowPickingMultipleVideo = YES;
    
    imagePickerVc.allowPickingVideo = NO;
    
    imagePickerVc.allowPickingGif = YES;
    
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = YES;
    
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"assets %@",assets);
        NSLog(@"infos %@",infos);
        
        //        if (photos.count==1) {
        //            [self imagesOne:photos];
        //        }else{
        //            //             [self imagesMore:assets];
        //            [self imagesMore:photos];
        //        }
        if (photos.count>0) {
            strongSelf.imageView.image =photos.firstObject;
        }
      
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark - Delegate

- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)) {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!results || !results.count) {
        return;
    }
    
    
    
    for (PHPickerResult *pickerResult in results) {
        
        
        NSItemProvider *itemProvider = pickerResult.itemProvider;
        NSString *suffix = itemProvider.registeredTypeIdentifiers.firstObject;
        
        //        [itemProvider  registerItemForTypeIdentifier:@"public.png" loadHandler:^(NSItemProviderCompletionHandler  _Null_unspecified completionHandler, Class  _Null_unspecified __unsafe_unretained expectedValueClass, NSDictionary * _Null_unspecified options) {
        //            NSLog(@"registerItemForTypeIdentifier===== %@  %@",expectedValueClass,options);
        //        }];
        
        //        [itemProvider loadItemForTypeIdentifier:@"public.png" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
        //
        //            NSLog(@"public.png===== %d",[item isKindOfClass:NSURL.class]);
        //        }];
        //
        //        [itemProvider loadItemForTypeIdentifier:@"com.compuserve.gif" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
        //
        //            NSLog(@"com.compuserve.gif=====%d",[ item isKindOfClass:[NSURL class]]);
        //        }];
        
        NSLog(@"suffix = %@",suffix);
        /// 始终是 NSItemProvider
        NSLog(@"itemProvider.class = %@",[itemProvider class]);
        NSLog(@"NSURL.canLoadObjectOfClass = %d",[itemProvider canLoadObjectOfClass:NSURL.class]);
        NSLog(@"UIImage.canLoadObjectOfClass = %d",[itemProvider canLoadObjectOfClass:UIImage.class]);
        NSLog(@"UIImage.isKindOfClass = %d",[itemProvider isKindOfClass:UIImage.class]);
        NSLog(@"NSURL.isKindOfClass = %d",[itemProvider isKindOfClass:NSURL.class]);
        NSLog(@"AVAsset.isKindOfClass = %d",[itemProvider isKindOfClass:AVAsset.class]);
        
        
        if ([itemProvider canLoadObjectOfClass:UIImage.class]) {
            
            if ([suffix isEqualToString:@"com.compuserve.gif"]) {
                
                /// 获取照片路径,其他的不明白含义
                //  @"public.url" 这个不行
                /// @"public.data" 获取照片路径,
                /// @"public.png"
                /// @"com.compuserve.gif"
                [itemProvider loadItemForTypeIdentifier:@"public.data" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
                    
                    if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
                        NSData *imageData = [NSData dataWithContentsOfURL:(NSURL *) item];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.imageView.image = [UIImage sd_imageWithGIFData:imageData];
                        });
                        [self.imageView2 sd_setImageWithURL:(NSURL *) item];
                        
                    }
                }];
                
            }else    if ([suffix isEqualToString:@"com.apple.live-photo-bundle"]) {
                
                
                [itemProvider loadItemForTypeIdentifier:@"com.apple.live-photo-bundle" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
                    NSLog(@"com.apple.live-photo-bundle = %@",item);
                    NSLog(@"com.apple.live-photo-bundle NSURL = %d",[item isKindOfClass:NSURL.class]);
                    NSLog(@"com.apple.live-photo-bundle UIImage = %d",[item isKindOfClass:UIImage.class]);
                    
                    if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
                        
                        
                        
                        if (@available(iOS 9.1, *)) {
                            
                            [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[item] placeholderImage:[UIImage imageNamed:@"1029x1029"] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    if (livePhoto) {
                                        NSLog(@"livePhoto222 = %@  info = %@",livePhoto,info);
                                        self.livePhotoView.livePhoto = livePhoto;
                                    }
                                    
                                    
                                });
                                
                                
                            }];
                            
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        
                        
                    }
                }];
                
                
                
                /// 获取照片路径,其他的不明白含义
                //  @"public.url" 这个不行
                /// @"public.data" 获取照片路径,
                /// @"public.png"
                /// @"com.compuserve.gif"
                [itemProvider loadItemForTypeIdentifier:@"public.data" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
                    NSLog(@"com.apple.live-photo-bundle NSURL.isKindOfClass = %d",[item isKindOfClass:NSURL.class]);
                    
                    if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
                        NSData *imageData = [NSData dataWithContentsOfURL:(NSURL *) item];
                        
                        NSLog(@"com.apple.live-photo-bundle public.data = %@",item);
                        
                        //                        [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[item] placeholderImage:[UIImage imageNamed:@"IMB_rz9Xy4.JPG"] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                        //
                        //                            NSLog(@"livePhoto = %@  info = %@",livePhoto,info);
                        //                            dispatch_async(dispatch_get_main_queue(), ^{
                        //
                        //                                self.livePhotoView.livePhoto = livePhoto;
                        //
                        //                            });
                        //
                        //
                        //                        }];
                        
                    }
                }];
                
            }  else {
                
                /// 可以显示 png / jpeg/ gif只能显示静态的
                [itemProvider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id <NSItemProviderReading> _Nullable object, NSError *_Nullable error) {
                    
                    NSLog(@"loadObjectOfClass UIImage = %d",[object isKindOfClass:UIImage.class]);
                    
                    NSLog(@"loadObjectOfClass PHLivePhoto = %d",[object isKindOfClass:PHLivePhoto.class]);
                    if ([object isKindOfClass:UIImage.class]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.imageView.image = (UIImage *) object;
                            self.imageView2.image =(UIImage *) object;
                        });
                    }
                    if ([object isKindOfClass:PHLivePhoto.class]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.livePhotoView.livePhoto = (PHLivePhoto *) object;
                        });
                    }
                }];
                
            }
            
            
            
            
            
            //        if ([suffix isEqualToString:@"public.png"] || [suffix isEqualToString:@"public.jpeg"] || [suffix isEqualToString:@"com.apple.live-photo-bundle"]) {
            //                __weak typeof(self) weakSelf = self;
            //                [itemProvider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id <NSItemProviderReading> _Nullable object, NSError *_Nullable error) {
            //
            //                    NSLog(@"object isKindOfClass = %d",[object isKindOfClass:UIImage.class]);
            //
            //                    if ([object isKindOfClass:UIImage.class]) {
            //                        __strong typeof(self) strongSelf = weakSelf;
            //                        dispatch_async(dispatch_get_main_queue(), ^{
            //
            //                            strongSelf.imageView.image = (UIImage *) object;
            //                            strongSelf.imageView2.image =(UIImage *) object;
            //                        });
            //
            //                    }
            //                }];
            
            //            [itemProvider loadItemForTypeIdentifier:@"public.image" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
            //                NSLog(@"public.image = %@",item);
            //                NSLog(@"public.image NSURL = %d",[item isKindOfClass:NSURL.class]);
            //                NSLog(@"public.image UIImage = %d",[item isKindOfClass:UIImage.class]);
            //
            //                if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
            //                    NSData *imageData = [NSData dataWithContentsOfURL:(NSURL *) item];
            //
            //                    dispatch_async(dispatch_get_main_queue(), ^{
            //                        self.imageView.image = [UIImage sd_imageWithGIFData:imageData];
            //                    });
            //                    [self.imageView2 sd_setImageWithURL:(NSURL *) item];
            //
            //                }
            //            }];
            
            
            
            //            [itemProvider loadItemForTypeIdentifier:@"com.apple.live-photo-bundle" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
            //                NSLog(@"com.apple.live-photo-bundle = %@",item);
            //                NSLog(@"com.apple.live-photo-bundle NSURL = %d",[item isKindOfClass:NSURL.class]);
            //                NSLog(@"com.apple.live-photo-bundle UIImage = %d",[item isKindOfClass:UIImage.class]);
            //
            //                if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
            //                    NSData *imageData = [NSData dataWithContentsOfURL:(NSURL *) item];
            //
            //                    dispatch_async(dispatch_get_main_queue(), ^{
            //                        self.imageView.image = [UIImage sd_imageWithGIFData:imageData];
            //                        [self.imageView2 sd_setImageWithURL:(NSURL *) item];
            //                    });
            //
            //
            //                }
            //            }];
            
            
            
            //        } else
            
            
            
            
        }else {
            
            __weak typeof(self) weakSelf = self;
            [itemProvider loadObjectOfClass:NSURL.class completionHandler:^(__kindof id <NSItemProviderReading> _Nullable object, NSError *_Nullable error) {
                
                NSLog(@"else NSURL.class = %@",object);
                
                
                
                //                if ([object isKindOfClass:UIImage.class]) {
                //                    __strong typeof(self) strongSelf = weakSelf;
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        strongSelf.imageView.image = (UIImage *) object;
                //                        strongSelf.imageView2.image =(UIImage *) object;
                //                    });
                //                }
            }];
            
            [itemProvider loadItemForTypeIdentifier:@"com.apple.quicktime-movie" options:nil completionHandler:^(__kindof id <NSSecureCoding> _Nullable item, NSError *_Null_unspecified error) {
                NSLog(@"com.apple.quicktime-movie = %@",item);
                NSLog(@"com.apple.quicktime-movie NSURL = %d",[item isKindOfClass:NSURL.class]);
                NSLog(@"com.apple.quicktime-movie UIImage = %d",[item isKindOfClass:UIImage.class]);
                //
                
                if ([(NSObject *) item isKindOfClass:[NSURL class]]) {
                    
                    
                    //                    [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[item] placeholderImage:[UIImage imageNamed:@"1028x1028"] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                    //
                    //                        NSLog(@"livePhoto = %@  info = %@",livePhoto,info);
                    //                        dispatch_async(dispatch_get_main_queue(), ^{
                    //
                    //                            self.livePhotoView.livePhoto = livePhoto;
                    //
                    //                        });
                    //
                    //
                    //                    }];
                    
                    
                    if (@available(iOS 9.1, *)) {
                        
                        [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"JPG"]],item] placeholderImage:[UIImage imageNamed:@"1029x1029"] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (livePhoto) {
                                    NSLog(@"livePhoto222 = %@  info = %@",livePhoto,info);
                                    self.livePhotoView.livePhoto = livePhoto;
                                }
                                
                                
                            });
                            
                            
                        }];
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    
                    
                }
                
            }];
            
            
            
            
        }
    }
    
    
    
}


-(void)_cutPhoto {
   
    
}




@end
