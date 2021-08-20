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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// hook类方法
        NSError *error;
        [object_getClass(UIImage.class) aspect_hookSelector:@selector(imageNamed:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSString *imageNamed) {
            NSInvocation  *invocation = aspectInfo.originalInvocation;
            if ([imageNamed isEqualToString:@"ax_icon_weixin"]) {
                id img= nil;
                img= [UIImage imageNamed:@"chongshe"];
                [invocation setReturnValue:&img];
//                NSLog(@"替换%@为,img=%@",imageNamed,img);
            }
        } error:&error];
        NSLog(@"ax_imageNamed error== %@",error);
        
    });
    
    //    id instance = info.instance;               //调用的实例对象
    //    id invocation = info.originalInvocation;   //原始的方法
    //    id arguments = info.arguments;             //参数
    //    [invocation invoke];                       //原始的方法，再次调用
    
    //        NSError *error;
    //        [object_getClass(UIImage.class) aspect_hookSelector:@selector(imageNamed:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSString *imageNamed) {
    //            NSInvocation  *invocation = aspectInfo.originalInvocation;
    //            if ([aspectInfo.arguments.firstObject isEqualToString:@"ax_icon_weixin"]) {
    //                id img= nil;
    //                img= [UIImage imageNamed:@"chongshe"];
    //                [invocation setReturnValue:&img];
    //                NSLog(@"img %@",img);
    //            }
    //        } error:&error];
    //        NSLog(@"ax_imageNamed error== %@",error);
    
    //    [UIImage ax_replaceClassMethodWithOriginal:@selector(imageNamed:) newSelector:@selector(ax_imageNamed:)];
}

+ (nullable UIImage *)ax_imageNamed:(NSString *)name{
    if ([name isEqualToString:@"ax_icon_weixin"]) {
        name =@"chongshe" ;
    }
    return [self ax_imageNamed:name];
}





@end
