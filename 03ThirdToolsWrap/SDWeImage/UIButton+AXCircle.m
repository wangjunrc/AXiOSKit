//
//  UIButton+AXCircle.m
//  BigApple
//
//  Created by Mole Developer on 2017/9/20.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIButton+AXCircle.h"
#import "UIImage+AXTool.h"
@implementation UIButton (AXCircle)

/**
 url路径 设置 BackgroundImage 圆形图片

 @param url url
 @param state 状态
 */
-(void)ax_setBackgroundImageCircleWithURL:(NSURL *)url forState:(UIControlState )state{
    
    [self sd_setBackgroundImageWithURL:url forState:state completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        CGFloat radius = MIN(self.frame.size.width*0.5, self.frame.size.height*0.5);
        image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
        [self setBackgroundImage:image forState:state];
    }];
    
}

/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param state 状态
 */
-(void)ax_setImageCircleWithURL:(NSURL *)url forState:(UIControlState )state {
    
   [self sd_setImageWithURL:url forState:state completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        CGFloat radius = MIN(self.frame.size.width*0.5, self.frame.size.height*0.5);
       image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
       [self setBackgroundImage:image forState:UIControlStateNormal];
       
   }];
    
}

@end
