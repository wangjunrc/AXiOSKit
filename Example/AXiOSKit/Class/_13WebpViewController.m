//
//  _13WebpViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_13WebpViewController.h"
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>
#import <AXiOSKit/AXiOSKit.h>
@import AssetsLibrary;
#import <Photos/Photos.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface _13WebpViewController ()

@end

@implementation _13WebpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self _webpImv];
    [self _UIImageView_gif];
    [self _FLAnimatedImageView_gif];
    [self _saveGIF];
    
    [self _loadBottomAttribute];
}


-(void )_webpImv{
    
    [self _titlelabel:@"UIImageView显示webp"];
    UIImageView *webpImv  = [[UIImageView alloc]init];
    [self _loadCenterXWithView:webpImv size:CGSizeMake(100, 100)];
    webpImv.backgroundColor = UIColor.redColor;
    /// webp 放在一个bundle 中,不然无法加载
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_webp" ofType:@"webp"  inDirectory:@"webp.bundle"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    ///根据不同的URL显示webp
    UIImage *img = [UIImage sd_imageWithWebPData:data];
    webpImv.image = img;
    webpImv.contentMode = UIViewContentModeScaleAspectFit;
}


-(void)_UIImageView_gif{
    [self _titlelabel:@"UIImageView显示gif"];
    
    UIImageView *gifImv  = [[UIImageView alloc]init];
    [self _loadCenterXWithView:gifImv size:CGSizeMake(100, 100)];
    ///根据不同的URL显示GIF
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
    
    //    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    ///
    UIImage *img = [UIImage sd_imageWithGIFData:data];
    gifImv.image = img;
    gifImv.contentMode = UIViewContentModeScaleAspectFit;
    
}
///FLAnimatedImageView
-(void)_FLAnimatedImageView_gif {
    
    {
        [self _titlelabel:@"FLAnimatedImageView显示本地gif,本地path 转url"];
        
        //    SDAnimatedImageView *imageView = [SDAnimatedImageView new];
        //    SDAnimatedImage *animatedImage = [SDAnimatedImage imageNamed:@"image.gif"];
        //    imageView.image = animatedImage;
        //    imageView sd_imageURL
        
        /// 4.4.0 版本之后换了另外一种方式， 新增加了 FLAnimatedImageView 来实现动态图片的展示，继承自 UIImageView
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        /// 本地 data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
        NSURL *URL =  [NSURL.alloc initFileURLWithPath:path];
        [imageView sd_setImageWithURL:URL];
    }
    
    {
        [self _titlelabel:@"FLAnimatedImageView显示URL gif,本地path转data"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        /// 本地 data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        imageView.animatedImage = image;
    }
    
    {
        [self _titlelabel:@"FLAnimatedImageView显示URL gif"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        [self _loadCenterXWithView:imageView size:CGSizeMake(100, 100)];
        
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSURL *URL = [NSURL URLWithString:@"http://img.autohome.com.cn/album/2009/3/16/52bba7e6-1b9e-4ebb-b887-56b41be4ba2a.gif"];
        /// 本地path 转url
        //    NSURL *URL = [[NSURL alloc]initFileURLWithPath:path];
        [imageView sd_setImageWithURL:URL];
    }
    
}




/// 保存GIF到相册
-(void)_saveGIF{
    ax_weakify(self);
    [self _buttonTitle:@"保存到相册"  handler:^(UIButton * _Nonnull btn) {
        ax_strongify(self);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972"
                                                         ofType:@"GIF"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        [data ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [self ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
            
        }];
    }];
    
}


- (void)dealloc{
    axLong_dealloc
}

@end
