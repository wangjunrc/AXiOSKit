//
//  UIImage+AXBundle.m
//  AXiOSKit
//
//  Created by axing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "UIImage+AXBundle.h"
#import "NSBundle+AXBundle.h"

@implementation UIImage (AXBundle)

+ (UIImage *)axBundle_imageNamed:(NSString *)imageName {
    if (imageName == nil || imageName.length == 0) {
        return nil;
    }
    
    NSBundle *imageBundle = [NSBundle ax_mainBundle];
    UIImage *image = [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
    if (!image) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}

+ (UIImage *)axBundle_noCache_imageNamed:(NSString *)imageName {
    if (!imageName) return nil;
    NSBundle *bundle =  [NSBundle ax_mainBundle];;
    
    NSString *prefix = imageName;
    NSInteger scale = (NSInteger)[UIScreen mainScreen].scale;
    
    UIImage *image = nil;
    while (scale > 0 && image == nil) {
        NSString *imageNameFull = nil;
        if (scale == 1) {
            imageNameFull =[prefix stringByAppendingString:@".png"];
        }else{
            imageNameFull =[prefix stringByAppendingFormat:@"@%ldx.png", (long)scale];
        }
        scale--;
        NSString *path = [bundle pathForResource:imageNameFull ofType:nil];
        image = [UIImage imageWithContentsOfFile:path];
    }
    
    if (!image && (NSInteger)[UIScreen mainScreen].scale == 1) { //当屏幕scale为1， 切没有1倍图是，取2倍图
        NSString *imageNameFull =[prefix stringByAppendingString:@"@2x.png"];
        NSString *path = [bundle pathForResource:imageNameFull ofType:nil];
        image = [UIImage imageWithContentsOfFile:path];
    }
    
    return image;
}

@end
