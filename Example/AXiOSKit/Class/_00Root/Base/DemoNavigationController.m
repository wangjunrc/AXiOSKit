//
//  AANavigationController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "DemoNavigationController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
@interface DemoNavigationController ()

@end

@implementation DemoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (@available(iOS 13.0, *)) {
//        UIColor *bgColor =  [UIColor ax_colorWithNormalStyle:UIColor.redColor darkStyle:UIColor.systemBackgroundColor];
//
//        [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
//    } else {
//        // Fallback on earlier versions
//    }
    
//    UIColor *bgColor =  [UIColor redColor];
//
//    [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.barTintColor = [UIColor redColor];
    
//    self.navigationBar.tintColor = [UIColor greenColor];
//    UIColor *color = UIColor.redColor;
//    [self ax_setNavBarBackgroundImageWithColor:color];
    self.navigationBar.barTintColor = [UIColor orangeColor];
//    self.rt_navigationController.useSystemBackBarButtonItem = YES;
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   
//    if (@available(iOS 11.0, *)) {
//        self.navigationItem.backButtonTitle  = @"";
//    } else {
//        // Fallback on earlier versions
//    }
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
//        backButtonItem.title = @"返回";
//        self.navigationItem.backBarButtonItem = backButtonItem;
    
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if(self.childViewControllers.count < 1){
        viewController.hidesBottomBarWhenPushed = NO;
        self.tabBarController.tabBar.hidden = NO;

    }else{
        viewController.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
    }

    [super pushViewController:viewController animated:animated];

//    if(self.childViewControllers.count>0){
//        /// 取消返回 文字
//        viewController.navigationItem.backBarButtonItem = [UIBarButtonItem.alloc
//                                                           initWithTitle:@""
//                                                           style:UIBarButtonItemStylePlain
//                                                           target:self
//                                                           action:nil];
//    }

}

//- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {
//
//
//    [super traitCollectionDidChange: previousTraitCollection];
//
////    if (@available(iOS 13.0, *)) {
////
////         UIColor *bgColor =  [UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traitCollection) {
////        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
////            return UIColor.systemBackgroundColor;
////        }else {
////            return UIColor.redColor;
////        }}];
////
////        [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
////    } else {
////
////    }
//
//}

//- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
//    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"AAA", nil)
//                                            style:UIBarButtonItemStylePlain
//                                           target:target
//                                           action:action];
//}



///二、跟视图为UINavigationController（在UINavigationController中设置）
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//
//    return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
//
//}

//6.0之后系统调用该方法

//- (BOOL)shouldAutorotate{
//
////系统会调用跟视图的旋转控制方法，所以我们将跟视图将控制条件交给顶层视图（顶层视图即我们需要控制的视图）
//
////系统调用该方法
//
//    return self.topViewController.shouldAutorotate;
//
//}
//
////6.0之后系统调用该方法,应该支持的方向
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//
//    return self.topViewController.supportedInterfaceOrientations;
//
//}

//-(BOOL)shouldAutorotate{
//    return self.topViewController.shouldAutorotate;
//}
////支持的方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}

@end