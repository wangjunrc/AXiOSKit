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
    
    [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle:message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
    
    
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
    //        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(dy_presentViewController:animated:completion:));
    //        // 交换方法实现
    //        method_exchangeImplementations(presentM, presentSwizzlingM);
    //    });
    
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
    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
    [self ax_addAction:action];
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
