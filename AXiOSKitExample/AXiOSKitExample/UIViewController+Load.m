//
//  UIViewController+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/3.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "UIViewController+Load.h"
#import <Aspects/Aspects.h>

#import <AXiOSKit/AXiOSKit.h>

@implementation UIViewController (Load)

// UIViewController+AOP类中：
+ (void)load {
    
    NSError *error;
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        
        if (@available(iOS 13.0, *)) {
                 vc.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor darkStyle:UIColor.systemBackgroundColor];
             }
        
        
//        [vc aop_viewDidLoad];
    } error:&error];
    if (error) NSLog(@"%@", error);
}
 
//- (void)aop_viewDidLoad {
//    [su aop_viewDidLoad];
//    // 添加自定义的代码
//    
//    if (@available(iOS 13.0, *)) {
//           self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor darkStyle:UIColor.systemBackgroundColor];
//       }
//}

@end
