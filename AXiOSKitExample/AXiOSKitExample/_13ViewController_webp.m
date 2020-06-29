//
//  _13ViewController_webp.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "_13ViewController_webp.h"
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>
#import <AXiOSKit/AXiOSKit.h>
@import AssetsLibrary;
#import <Photos/Photos.h>

#import "UIViewController+AXKit.h"


@interface _13ViewController_webp ()


@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation _13ViewController_webp

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView1.backgroundColor = UIColor.redColor;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"webp" inDirectory:@"images.bundle"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *img = [UIImage sd_imageWithWebPData:data];
    self.imageView1.image = img;
    
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://images21.happyjuzi.com/test/ea/09/91f522741b7a0976b5f21a3b9f78.jpg!200.nw.webp"]];
    
    //    self.animatedImageView3.contentMode = UIViewContentModeScaleAspectFit;
    self.animatedImageView3.backgroundColor = UIColor.redColor;
    [self.animatedImageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.autohome.com.cn/album/2009/3/16/52bba7e6-1b9e-4ebb-b887-56b41be4ba2a.gif"]];
    
    
}
- (IBAction)toSaveImage:(id)sender {
    
    //   NSURL *URL =  [NSURL URLWithString:@"http://img.autohome.com.cn/album/2009/3/16/52bba7e6-1b9e-4ebb-b887-56b41be4ba2a.gif"];
    //    NSData *data =[NSData dataWithContentsOfURL:URL];
    
    
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"122" ofType:@"GIF"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"jpg"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    [data ax_savePhotoLibraryHandler:^(BOOL success, NSError * _Nullable error) {
        AXLoger(@"success = %ld",success);
    }];
    
    
}



@end
