//
//  _38DirectionVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/4/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_38DirectionVC.h"
#import "DemoAppSetting.h"
@interface _38DirectionVC ()

@end

@implementation _38DirectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前控制器可以旋转";
    self.view.backgroundColor = UIColor.blueColor;
    [self _titlelabel:@"当前VC可以旋转"];
    [self _buttonTitle:@"左旋转" handler:^(UIButton * _Nonnull btn) {
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }];

    [self _buttonTitle:@"右旋转" handler:^(UIButton * _Nonnull btn) {
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }];
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"dismiss" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self _lastLoadBottomAttribute];
    
//    UILabel *label = UILabel.alloc.init;
//    [self.view addSubview:label];
//    label.numberOfLines  = 0;
//    label.backgroundColor = UIColor.whiteColor;
//    label.textColor = UIColor.blackColor;
//    label.text = @"当前VC可以旋转";
//
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_equalTo(0);
////        make.centerX.mas_equalTo(0);
//        make.left.mas_equalTo(5);
//        make.right.mas_equalTo(-5);
////        make.center.mas_offset(0);
//    }];
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    /// 要在这里默认一下
////    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
////    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//}
//设置状态栏转屏时不隐藏
//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}


//打开允许旋转
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DemoAppSetting.shared.allowing = YES;
}

//关闭允许旋转
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    DemoAppSetting.shared.allowing  = NO;
}

//支持旋转
- (BOOL)shouldAutorotate {
    return YES;
}


//支持旋转
//-(BOOL)shouldAutorotate{
//    return YES;
//}
//
////支持的方向 ,用UIInterfaceOrientationMaskAll 会影藏侧滑
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}
//
////一开始的方向  很重要
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeLeft;
//}
- (void)dealloc {
    axLong_dealloc;
}
@end
