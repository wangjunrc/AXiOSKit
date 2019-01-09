//
//  UIImage+AXLocal.h
//  AXiOSTools
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AXLocal)

/**
 读取图片
 
 @param imageName 图片名称
 */
+ (UIImage *)axLocale_imageNamed:(NSString *)imageName;

/**
 针对大图，不加入内存缓存的加载方式
 */
+ (UIImage *)axLocale_noCache_imageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
