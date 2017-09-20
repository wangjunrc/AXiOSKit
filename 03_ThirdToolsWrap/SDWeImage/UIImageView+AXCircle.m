//
//  UIImageView+AXCircle.m
//  BigApple
//
//  Created by Mole Developer on 2017/9/20.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIImageView+AXCircle.h"

@implementation UIImageView (AXCircle)

/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param state 状态
 */
-(void)ax_setImageCircleWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
        image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
      
        self.image = image;
        
    }];
    
}

@end
