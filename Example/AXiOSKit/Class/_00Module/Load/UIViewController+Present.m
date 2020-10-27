//
//  UIViewController+Present.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "UIViewController+Present.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
@implementation UIViewController (Present)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(dy_presentViewController:animated:completion:));
        // 交换方法实现
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
    
    /// usingBlock: 第一个参数 调用对象,第二个是方法的第一次参数
     [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo,UIViewController *presentViewController) {
         /// aspectInfo.arguments.firstObject 就是 presentViewController
         if (![presentViewController isKindOfClass:[UIAlertController class]]) {
             [aspectInfo.originalInvocation invoke];
         }else{
             UIAlertController *alertController = (UIAlertController *)presentViewController;
            /// 这里用 == nil ,不要用length==0,业务需求不一样
             if (alertController.title != nil || alertController.message != nil) {
                 [aspectInfo.originalInvocation invoke];
             }
         }
     } error:nil];
    
    
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
