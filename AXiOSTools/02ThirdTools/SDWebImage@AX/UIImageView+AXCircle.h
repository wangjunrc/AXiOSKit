//
//  UIImageView+AXCircle.h
//  BigApple
//
//  Created by liuweixing on 2017/9/20.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include("UIImageView+WebCache.h")
#import "UIImageView+WebCache.h"
#endif

@interface UIImageView (AXCircle)

#if __has_include("UIImageView+WebCache.h")

/**
 url路径 设置 image 圆形图片

 @param url url
 @param placeholderImage 占位图片
 */
- (void)ax_setImageCircleWithURL:(NSURL *)url
                placeholderImage:(UIImage *)placeholderImage;
#endif

@end
