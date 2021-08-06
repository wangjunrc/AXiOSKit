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
#import <ReactiveObjC/ReactiveObjC.h>
#import <AXiOSKit/NSObject+AXAssistant.h>
//@import  WRNavigationBar;

@interface DemoNavigationController ()

@end

@implementation DemoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    [RACObserve(self, title) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"DemoNavigationController title = %@",x);
        if (ax_objc_is_nil(x)) {
            self.title =  @"";
        }
        
        NSLog(@"DemoNavigationController self.title = %@",self.title);
        
    }];
    
    
    
    //状态栏颜色
    self.navigationBar.barStyle = UIBarStyleDefault;
    //半透明--- view坐标为0,0, NO view坐标为0,64
    //    self.navigationBar.translucent = NO;
    
    /// 背景色
    self.navigationBar.barTintColor = [UIColor redColor];
    self.navigationBar.backgroundColor = [UIColor orangeColor];
    // 设置导航栏下边线（投影）去掉
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    UIImage *backGroundImage = [UIImage imageNamed:@"nav_bg_img_1"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    
    /// 返回按钮 颜色
    self.navigationBar.tintColor = UIColor.purpleColor;
    // 设置导航栏默认标题的颜色和字体的大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.blueColor};
    
    
    
    //    self.navigationBar.topItem.title = @"";
    
    //    if (@available(iOS 13.0, *)) {
    //        UIImage *img = [[UIImage systemImageNamed:@"backward.frame.fill"] imageWithTintColor:UIColor.redColor];;
    //        UIButton *leftBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 16)];
    //        [leftBut setImage:img forState:UIControlStateNormal];
    //        [leftBut addTarget:self action:@selector(clickBackLastPageAction) forControlEvents:UIControlEventTouchUpInside];
    //        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
    //        self.navigationItem.leftBarButtonItem = backBar;
    //    }
    
    
    
    
    // self.navigationItem.leftItemsSupplementBackButton = NO; // 设置YES，以达到页面可以左滑的目的（但是会有系统"<"）
    //    self.interactivePopGestureRecognizer.delegate = (id)self; // 自定义 按钮，并实现右滑返回效果
    //    self.edgesForExtendedLayout = UIRectEdgeNone; // self.view 的坐标在（0，导航栏高度+状态栏高度）
    //    self.navigationBar.translucent = NO;
    
    
    // 替换系统的“<"图标,去除文字,必须同时实现,且以backIndicatorTransitionMaskImage为主
    
//    self.navigationBar.topItem.title = @"";
//    self.navigationItem.title  = @"";
    
    //导航条返回时文字的设置

//        self.navigationController.navigationBar.topItem.title= @"";

        //去掉导航条返回时文字

//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    /// 这个不要放在 UINavigationController 里面,不然无效
    self.navigationController.navigationBar.topItem.title= @"";
    
    UIImage *img = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img2 = [UIImage imageNamed:@"nav_back_2"];
//    img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (@available(iOS 13.0, *)) {
        img2 = [img2 imageWithTintColor:UIColor.redColor];
    }
    self.navigationBar.backIndicatorImage = img;
    self.navigationBar.backIndicatorTransitionMaskImage = img2;
    
    
//    [self setNavBarAppearence];
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

- (void)setNavBarAppearence
{
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    //    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
    //    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
//    UIColor *MainNavBarColor = [UIColor orangeColor];
//    //    UIColor * MainViewColor   = [UIColor purpleColor];
//
//    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
//    [WRNavigationBar wr_widely];
//    [WRNavigationBar wr_setBlacklist:@[@"SpecialController",
//                                       @"TZPhotoPickerController",
//                                       @"TZGifPhotoPreviewController",
//                                       @"TZAlbumPickerController",
//                                       @"TZPhotoPreviewController",
//                                       @"TZVideoPlayerController"]];
//
//    // 设置导航栏默认的背景颜色
//    [WRNavigationBar wr_setDefaultNavBarBarTintColor:MainNavBarColor];
//    // 设置导航栏所有按钮的默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
//    // 设置导航栏标题默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
//    // 统一设置状态栏样式
//    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
//    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
//    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}


/// 指定控制器旋转: 跟随当前导航控制器的设置
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}
@end
