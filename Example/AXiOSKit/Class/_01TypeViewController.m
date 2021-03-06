//
//  _01TypeViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_01TypeViewController.h"

@interface _01TypeViewController ()
@property(nonatomic,assign)BOOL navigationBarHidden;
@end

@implementation _01TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    if (self.ax_barTintColor) {
        
        if ([self.ax_barTintColor isEqual:UIColor.clearColor]) {
            
            
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
               self.navigationController.navigationBar.translucent = YES;//设置透明
            
//            self.navigationController.navigationBar.translucent = YES;
            //设置导航栏背景图片为一个空的image，这样就透明了
               [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
               
//            self.navigationController.navigationBar.translucent = YES;//设置不透明
            
            
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//
//            self.navigationController.navigationBar.translucent = YES;
//            self.extendedLayoutIncludesOpaqueBars = YES;

            
//            if (@available(iOS 11.0, *)) {
//
//                    }else {
//                        self.automaticallyAdjustsScrollViewInsets = NO;
//                    }


            
            
        }else{
            self.navigationController.navigationBar.barTintColor = self.ax_barTintColor;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:self.ax_barTintColor]
                                                          forBarMetrics:UIBarMetricsDefault];
            
        }
      
    }
    
    
    __weak typeof(self) weakSelf = self;
    [self _p00ButtonTitle:@"黄色" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01TypeViewController *vc = _01TypeViewController.alloc.init;
        vc.ax_barTintColor = UIColor.orangeColor;
        [strongSelf ax_pushVC:vc];
    }];
    
    [self _p00ButtonTitle:@"蓝色" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01TypeViewController *vc = _01TypeViewController.alloc.init;
        vc.ax_barTintColor = UIColor.blueColor;
        [strongSelf ax_pushVC:vc];
    }];
    
    [self _p00ButtonTitle:@"透明" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01TypeViewController *vc = _01TypeViewController.alloc.init;
        vc.ax_barTintColor = UIColor.clearColor;
//        vc.navigationBarHidden = YES;
        [strongSelf ax_pushVC:vc];
    }];
    
    
    [self _p00ButtonTitle:@"绿色+隐藏" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01TypeViewController *vc = _01TypeViewController.alloc.init;
        vc.ax_barTintColor = UIColor.greenColor;
        vc.navigationBarHidden = YES;
        
        [strongSelf ax_pushVC:vc];
    }];
   
    
    /// 底部约束
    [self _loadBottomAttribute];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    super.viewWillAppear(animated)
//    navigationController?.setNavigationBarHidden(currentNavigationBarData.prefersHidden, animated: animated)
//    [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:NO];

//    if (self.navigationBarHidden) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    self.ax_controllerObserve.hiddenNavigationBar = self.navigationBarHidden;
    
}



@end
