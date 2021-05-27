//
//  UIImage+AXBundle.h
//  AXiOSKit
//
//  Created by axing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AXBundle)

/**
 读取图片
 
 @param imageName 图片名称
 */
+ (UIImage *)axBundle_imageNamed:(NSString *)imageName;

/**
 针对大图，不加入内存缓存的加载方式
 */
+ (UIImage *)axBundle_noCache_imageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
