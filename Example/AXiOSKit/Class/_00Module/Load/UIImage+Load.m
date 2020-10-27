//
//  UIImage+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/20.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "UIImage+Load.h"
#import <Aspects/Aspects.h>

#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/NSBundle+AXBundle.h>
#import <AXiOSKit/NSObject+AXRuntime.h>

@implementation UIImage (Load)


+ (void)load {
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSError *error;
//        [object_getClass(UIImage.class) aspect_hookSelector:@selector(imageNamed:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//            id obj = aspectInfo.instance;
//            NSLog(@"ax_imageNamed == %@",obj);
//        } error:&error];
//        NSLog(@"ax_imageNamed error== %@",error);
//    });
}
+ (nullable UIImage *)ax_imageNamed:(NSString *)name{
    NSLog(@"ax_imageNamed == %@",name);
    return [self ax_imageNamed:name];
}

@end
