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

@interface _13WebpViewController ()

@end

@implementation _13WebpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView *webpImv  = [self webpImv:nil];
    UIImageView *gifImv  = [self gifImv:webpImv];
    UIImageView *gifImv_fl  = [self gifImv_fl:gifImv];
    UIView *saveGIF  = [self saveGIF:gifImv_fl];
}

-(UIImageView *)webpImv:(UIView *)topView{
    
    UIImageView *webpImv  = [[UIImageView alloc]init];
    webpImv.frame = CGRectMake(100, 10, 200, 200);
    
    webpImv.backgroundColor = UIColor.redColor;
    /// webp 放在一个bundle 中,不然无法加载
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_webp" ofType:@"webp"  inDirectory:@"webp.bundle"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    ///根据不同的URL显示webp
    UIImage *img = [UIImage sd_imageWithWebPData:data];
    webpImv.image = img;
    webpImv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:webpImv];
    
    return webpImv;
}


-(UIImageView *)gifImv:(UIView *)topView{
    
    UIImageView *gifImv  = [[UIImageView alloc]init];
    gifImv.frame = CGRectMake(100, 100, 200, 200);
    gifImv.top = topView.bottom+10;
    gifImv.backgroundColor = UIColor.redColor;
    ///根据不同的URL显示GIF
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
    
    //    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    ///
    UIImage *img = [UIImage sd_imageWithGIFData:data];
    gifImv.image = img;
    gifImv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:gifImv];
    
    return gifImv;
    
}
///FLAnimatedImageView
-(UIImageView *)gifImv_fl:(UIView *)topView{
    
    
    
//    SDAnimatedImageView *imageView = [SDAnimatedImageView new];
//    SDAnimatedImage *animatedImage = [SDAnimatedImage imageNamed:@"image.gif"];
//    imageView.image = animatedImage;
//    imageView sd_imageURL
    
    /// 4.4.0 版本之后换了另外一种方式， 新增加了 FLAnimatedImageView 来实现动态图片的展示，继承自 UIImageView
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    
    imageView.frame = CGRectMake(100, 100, 200, 200);;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    /// 本地 data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
    //       NSData *data = [NSData dataWithContentsOfFile:path];
    //       FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    //      imageView.animatedImage = image;
    
    NSURL *URL = [NSURL URLWithString:@"http://img.autohome.com.cn/album/2009/3/16/52bba7e6-1b9e-4ebb-b887-56b41be4ba2a.gif"];
    /// 本地path 转url
    //    NSURL *URL = [[NSURL alloc]initFileURLWithPath:path];
    [imageView sd_setImageWithURL:URL];
    
    imageView.top = topView.bottom+10;
    
    imageView.backgroundColor = UIColor.redColor;
    
    return imageView;
    
    
}

/// 保存GIF到相册
-(UIView *)saveGIF:(UIView *)topView{
    
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    btn.frame =CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"保存到相册" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.orangeColor;
    btn.top = topView.bottom+10;
    ax_weakify(self);
    [btn ax_addTargetBlock:^(UIButton * _Nullable button) {
        ax_strongify(self);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972"
                                                         ofType:@"GIF"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        [data ax_savePhotoLibraryHandler:^(BOOL success, NSError *_Nullable error) {
            AXLoger(@"success = %ld", success);
            [self ax_showAlertByTitle:success ? @"保存成功" : @"保存失败"];
            
        }];
    }];
    
    
    return btn;
}


- (void)dealloc{
    axLong_dealloc
}

@end
