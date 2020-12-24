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
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@implementation NSObject (Load)

+ (void)load {
    
    /// 这个方式,是 UIAlertController init 后改变颜色, 后续使用再改变颜色,以使用颜色为主
    [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle:message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
    
    /// usingBlock: 第一个参数 调用对象,第二个是方法的第一次参数
    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo,UIViewController *presentViewController) {
        /// aspectInfo.arguments.firstObject 就是 presentViewController
        if (![presentViewController isKindOfClass:[UIAlertController class]]) {
            [aspectInfo.originalInvocation invoke];
        }else{
            UIAlertController *alertController = (UIAlertController *)presentViewController;
            /// 这里用 == nil ,不要用length==0,业务需求不一样
            /// UIAlertControllerStyleAlert 才拦截
            if (alertController.title != nil || alertController.message != nil || alertController.preferredStyle !=UIAlertControllerStyleAlert) {
                [aspectInfo.originalInvocation invoke];
            }
        }
    } error:nil];
    
    
}


-(void)ax_addAction:(UIAlertAction *)action{
//    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
//    
//    if (@available(iOS 13.0, *)) {
//        UIImage *secondImage = [[UIImage systemImageNamed:@"square.and.arrow.up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [action setValue:secondImage forKey:@"image"];
//    }
    
    [self ax_addAction:action];
}

+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alert =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert.title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alert.title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, titleStr.string.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.string.length)];
        [alert setValue:titleStr forKey:@"attributedTitle"];
    }
    if(alert.message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0, messageStr.string.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.string.length)];
        [alert setValue:messageStr forKey:@"attributedMessage"];
    }
    return alert;
    
}


- (void)dy_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
