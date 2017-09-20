//
//  UIButton+AXCircle.m
//  BigApple
//
//  Created by Mole Developer on 2017/9/20.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIButton+AXCircle.h"

@implementation UIButton (AXCircle)

/**
 url路径 设置 BackgroundImage 圆形图片

 @param url url
 @param state 状态
 */
-(void)ax_setBackgroundImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage {
    
    [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
        image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }];
}

/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param state 状态
 */
-(void)ax_setImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage {
    
   [self sd_setImageWithURL:url forState:state placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
       CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
       image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
       [self setBackgroundImage:image forState:UIControlStateNormal];
       
   }];
    
}

@end
