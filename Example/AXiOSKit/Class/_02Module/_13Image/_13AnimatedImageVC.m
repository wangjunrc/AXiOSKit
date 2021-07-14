//
//  _13WebpViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_13AnimatedImageVC.h"
#import "AXUserSwiftImport.h"
#import <SDWebImageFLPlugin/FLAnimatedImageView+WebCache.h>
@import AXiOSKit;
@import AssetsLibrary;
@import FLAnimatedImage;
@import SDWebImage;
@import TZImagePickerController;

@interface _13AnimatedImageVC ()

@property(nonatomic,strong)NSData *gifData;
@property(nonatomic, strong) NSData *apngData;
@property(nonatomic,strong)NSURL *apngURL;


@end

@implementation _13AnimatedImageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self _titlelabel:@"iPhone相册不识别apng动画效果"];
    
    [self _show_gif];
    [self _show_apng];
    [self _saveGIF];
    [self _show_webp];
    [self _lastLoadBottomAttribute];
}


- (NSData *)gifData {
    if (!_gifData) {
        _gifData = [NSData ax_mainBundleDataName:@"Image.bundle/test_gif_bear.gif"];
    }
    return _gifData;
}

- (NSData *)apngData {
    if (!_apngData) {
        _apngData= [NSData ax_mainBundleDataName:@"Image.bundle/test_apng_elephant.png"];
    }
    return _apngData;
}


-(void)_show_gif {
    
    [self _dividerLabel:@"显示 gif"];
    
    NSData *data = self.gifData;
    NSURL *URL = [NSURL URLWithString:@"https://gitee.com/axinger/picture/raw/master/img/test_gif_bear.gif"];
    [self _dividerLabel:@"本地data: gif"];
    
    {
        [self _titlelabel:@"gif data: UIImageView"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        imageView.image = [UIImage sd_imageWithGIFData:data];
    }
    
    {
        [self _titlelabel:@"gif data: SDAnimatedImageView \n没有data方法"];
        SDAnimatedImageView *imageView = [SDAnimatedImageView.alloc init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        /// 这2句,同时控制是否重复
        imageView.shouldCustomLoopCount = YES;
        imageView.animationRepeatCount = 0;
        
        NSURL *URL = [NSBundle.mainBundle URLForResource:@"Image.bundle/test_gif_bear.gif" withExtension:nil];
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        [self _titlelabel:@"gif data: FLAnimatedImageView \n无效"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
        ;
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        imageView.animatedImage = image;
    }
    
    
    [self _dividerLabel:@"gif URL"];
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"gif URL: UIImageView"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        [self _titlelabel:@"gif URL: SDAnimatedImageView"];
        SDAnimatedImageView *imageView = [SDAnimatedImageView.alloc init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        /// 这2句,同时控制是否重复
        imageView.shouldCustomLoopCount = YES;
        imageView.animationRepeatCount = 0;
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"gif URL: FLAnimatedImageView"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
        ;
        
        [imageView sd_setImageWithURL:URL];
        
    }
}



-(void)_show_apng {
    
    [self _dividerLabel:@"显示 apng"];
    
    NSData *data = self.apngData;
    NSURL *URL = [NSURL URLWithString:@"https://gitee.com/axinger/picture/raw/master/img/test_apng_elephant.png"];
    
    [self _dividerLabel:@"本地data: apng"];
    
    
    {
        [self _titlelabel:@"apng data: UIImageView"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        imageView.image = [UIImage sd_imageWithGIFData:data];
    }
    
    {
        [self _titlelabel:@"apng data: SDAnimatedImageView \n没有data方法"];
        SDAnimatedImageView *imageView = [SDAnimatedImageView.alloc init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        /// 这2句,同时控制是否重复
        imageView.shouldCustomLoopCount = YES;
        imageView.animationRepeatCount = 0;
        
        NSURL *URL = [NSBundle.mainBundle URLForResource:@"Image.bundle/test_apng_elephant.png" withExtension:nil];
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        [self _titlelabel:@"apng data: FLAnimatedImageView \n无效"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
        ;
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        imageView.animatedImage = image;
    }
    
    {
        [self _titlelabel:@"apng data: APNGKit"];
        _13ApngView2 *imageView = [_13ApngView2.alloc initWithData:data];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
    }
    
    [self _dividerLabel:@"apng URL"];
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"apng URL: UIImageView"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        [self _titlelabel:@"apng URL: SDAnimatedImageView"];
        SDAnimatedImageView *imageView = [SDAnimatedImageView.alloc init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        /// 这2句,同时控制是否重复
        imageView.shouldCustomLoopCount = YES;
        imageView.animationRepeatCount = 0;
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        /// FLAnimatedImageView
        [self _titlelabel:@"apng URL: FLAnimatedImageView"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
        ;
        
        [imageView sd_setImageWithURL:URL];
        
    }
    
    {
        [self _titlelabel:@"apng URL: APNGKit"];
        _13ApngView2 *imageView = [_13ApngView2.alloc initWithUrl:URL];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        
    }
}




-(void )_show_webp{
    
    [self _dividerLabel:@"UIImageView显示webp,用data方式"];
    {
        [self _titlelabel:@"webp data"];
        UIImageView *imageView  = [[UIImageView alloc]init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        NSData *data = [NSData ax_mainBundleDataName:@"Image.bundle/test_webp.webp"];
        imageView.image = [UIImage.alloc initWithData:data];;
    }
    
    {
        
        [self _titlelabel:@"webp URL"];
        UIImageView *imageView  = [[UIImageView alloc]init];
        [self _addCenterView:imageView size:CGSizeMake(100, 100)];
        NSURL *URL = [NSURL URLWithString:@"https://gitee.com/axinger/picture/raw/master/img/test_webp.webp"];
        [imageView sd_setImageWithURL:URL];
    }
}

/// 保存GIF到相册
-(void)_saveGIF{
    
    [self _dividerLabel:@"保存到相册"];
    
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"保存gif到相册"  handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.gifData ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [strongSelf ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
            
        }];
    }];
    
    [self _buttonTitle:@"保存apng到相册,data方式-无效"  handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.apngData ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [strongSelf ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
            
        }];
    }];
    
    UIImageView *imageView  = [[UIImageView alloc]init];
    [self _addCenterView:imageView size:CGSizeMake(100, 100)];
    
    
    __block NSData *gifData = nil;
    [self _buttonTitle:@"打开相册"  handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _TZImagePickerController:^(NSData *data) {
            UIImage *img = [UIImage sd_imageWithGIFData:data];
            imageView.image = img;
            gifData = data;
        }];
    }];
    
    [self _buttonTitle:@"查看图片"  handler:^(UIButton * _Nonnull btn) {
        NSLog(@"gifData=%ld",gifData.length);
    }];
    
    
    [self _buttonTitle:@"保存到相册ax_savePhotoLibraryHandler"  handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [gifData ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [strongSelf ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
        }];
    }];
    
    [self _buttonTitle:@"保存到相册,TZImageManager,不能gif"  handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [TZImageManager.manager savePhotoWithImage:[UIImage.alloc initWithData:gifData] completion:^(PHAsset *asset, NSError *error) {
            AXLoger(@"error = %@", error);
            [strongSelf ax_showAlertByTitle:!error ? @"保存成功" : @"保存失败"];
        }];
    }];
    
    
}

-(void)_TZImagePickerController:(void(^)(NSData *data))block {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc. allowPickingMultipleVideo = YES;
    imagePickerVc.allowPickingVideo = YES;
    
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        
        NSLog(@"assets %@",assets);
        NSLog(@"infos %@",infos);
        
        [TZImageManager.manager getOriginalPhotoDataWithAsset:assets.firstObject completion:^(NSData *data, NSDictionary *info, BOOL isDegraded) {
            if (block) {
                block(data);
            }
        }];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

@end
