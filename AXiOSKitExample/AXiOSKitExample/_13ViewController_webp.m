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

@interface _13ViewController_webp ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedImageView3;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
