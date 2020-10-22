//
//  NSObject+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/20.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "NSObject+Load.h"
#import <Aspects/Aspects.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/NSBundle+AXBundle.h>
#import <AXiOSKit/NSObject+AXRuntime.h>

@implementation NSObject (Load)

+ (void)load {
    
    //        NSError *error;
    //        [UIAlertController aspect_hookSelector:@selector(addAction:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
    //            id obj = aspectInfo.instance;
    //            NSLog(@"UIAlertAction == %@",obj);
    //    //        [self setValue:DL_THEME_TINT_COLOR forKey:@"_titleTextColor"];
    //        } error:&error];
    
    
    //    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
    
//    [UIAlertController class]
//    id metaClass = object_getClass(UIAlertController.class);
        [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle: message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    
    
  
//        [objc_getMetaClass(NSStringFromClass(UIAlertController.class).UTF8String) aspect_hookSelector:@selector(alertControllerWithTitle: message:preferredStyle:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//                id obj = aspectInfo.instance;
//                NSLog(@"UIAlertAction == %@",obj);
//        //        [self setValue:DL_THEME_TINT_COLOR forKey:@"_titleTextColor"];
//            } error:nil];
    
    
    //    [UIViewController ax_replaceInstanceMethodWithOriginal:@selector(presentViewController:animated:completion:) newSelector:@selector(ax_presentViewController:animated:completion:)];
    
//    [UIImage ax_replaceInstanceMethodWithOriginal:@selector(imageNamed:) newSelector:@selector(ax_imageNamed:)];
    
//    [UIImage aspect_hookSelector:@selector(imageNamed:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        id obj = aspectInfo.instance;
//        NSLog(@"ax_imageNamed == %@",obj);
//        //        [self setValue:DL_THEME_TINT_COLOR forKey:@"_titleTextColor"];
//    } error:nil];
    
}
+ (nullable UIImage *)ax_imageNamed:(NSString *)name{
    NSLog(@"ax_imageNamed == %@",name);
    return [self ax_imageNamed:name];
}

-(void)ax_addAction:(UIAlertAction *)action{
    
    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
    [self ax_addAction:action];
}

- (void)ax_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        
        UIAlertController *alertController = ( UIAlertController *)viewControllerToPresent;
        
        
        if ( alertController.title.length>0) {
            
            //修改title字体及颜色
            NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alertController.title];
            [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, titleStr.length)];
            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.length)];
            [alertController setValue:titleStr forKey:@"attributedTitle"];
        }
        
        
        if ( alertController.message.length>0) {
            // 修改message字体及颜色
            NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alertController.message];
            [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor orangeColor] range:NSMakeRange(0, messageStr.length)];
            [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
            [alertController setValue:messageStr forKey:@"attributedMessage"];
        }
    }
    
    [self ax_presentViewController:viewControllerToPresent animated:flag completion:completion];
}


+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alertController =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleStr.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.length)];
        [alertController setValue:titleStr forKey:@"attributedTitle"];
    }
    if(message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0, messageStr.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
        [alertController setValue:messageStr forKey:@"attributedMessage"];
    }
  
    
    return alertController;
    
}

@end
