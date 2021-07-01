//
//  _02NavColorViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_02NavColorViewController.h"
@import  WRNavigationBar;

@interface _02NavColorViewController ()

@property(nonatomic,assign)BOOL navigationBarHidden;
@end

@implementation _02NavColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    if (self.ax_barTintColor) {
        [self wr_setNavBarBarTintColor:self.ax_barTintColor];
    }
    
    if (self.navigationBarHidden) {
        [self wr_setNavBarBackgroundAlpha:0];
    }
    
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"绿色" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _02NavColorViewController *vc = _02NavColorViewController.alloc.init;
        vc.ax_barTintColor = UIColor.greenColor;
        [strongSelf ax_pushVC:vc];
    }];
    
    [self _buttonTitle:@"蓝色" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _02NavColorViewController *vc = _02NavColorViewController.alloc.init;
        vc.ax_barTintColor = UIColor.blueColor;
        [strongSelf ax_pushVC:vc];
    }];
    
    [self _buttonTitle:@"透明" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _02NavColorViewController *vc = _02NavColorViewController.alloc.init;
        vc.ax_barTintColor = UIColor.clearColor;
//        vc.navigationBarHidden = YES;
        [strongSelf ax_pushVC:vc];
    }];
    
    
    [self _buttonTitle:@"隐藏" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _02NavColorViewController *vc = _02NavColorViewController.alloc.init;
        vc.navigationBarHidden = YES;
        vc.ax_barTintColor = UIColor.blueColor;
        [strongSelf ax_pushVC:vc];
    }];
   
    
    /// 底部约束
    [self _lastLoadBottomAttribute];
    
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
////    super.viewWillAppear(animated)
////    navigationController?.setNavigationBarHidden(currentNavigationBarData.prefersHidden, animated: animated)
////    [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:NO];
//
////    if (self.navigationBarHidden) {
////        self.navigationController.interactivePopGestureRecognizer.delegate = self;
////    }
//    self.ax_controllerObserve.hiddenNavigationBar = self.navigationBarHidden;
//
//}



@end
