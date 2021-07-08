//
//  _32LottieVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/4.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_32LottieVC.h"
#import <Lottie/Lottie.h>
#import <Masonry/Masonry.h>


@interface _32LottieVC ()


@end

@implementation _32LottieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self _buttonTitle:@"MBP" handler:^(UIButton * _Nonnull btn) {
        
        [MBProgressHUD ax_showAnimSuccess:@"我是成功"];
        
    }];
    
    [self _buttonTitle:@"MBP" handler:^(UIButton * _Nonnull btn) {
        
        [MBProgressHUD ax_showAnimError:@"我是失败"];
        
    }];
    [self _buttonTitle:@"MBP" handler:^(UIButton * _Nonnull btn) {
        
        [MBProgressHUD ax_showAnimLoading:@"loading123"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD ax_hideAnimHUD];
        });
        
    }];
    
    
    [self _titlelabel:@"一个文件有4个动画"];
    LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"lf20_loading_all"];
    animationView.contentMode = UIViewContentModeScaleAspectFill;
    [self.containerView addSubview:animationView];
    [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.width.height.mas_equalTo(200);
        make.centerX.mas_equalTo(0);
    }];
    //    [animationView play];
    //    animationView.loopAnimation = YES;
    self.bottomAttribute = animationView.mas_bottom;
    
    @weakify(animationView);
    
    [self _buttonTitle:@"播放第1个,是load" handler:^(UIButton * _Nonnull btn) {
        @strongify(animationView)
        
        [animationView playToProgress:0.25 withCompletion:^(BOOL animationFinished) {
            
        }];
        animationView.completionBlock = ^(BOOL animationFinished) {
            
        };
        
    }];
    [self _buttonTitle:@"播放第2个,是成功" handler:^(UIButton * _Nonnull btn) {
        @strongify(animationView)
        [animationView playFromProgress:0.25 toProgress:0.5 withCompletion:^(BOOL animationFinished) {
            
        }];
        
    }];
    
    [self _buttonTitle:@"播放第3个,是load" handler:^(UIButton * _Nonnull btn) {
        @strongify(animationView)
        
        [animationView playFromProgress:0.5 toProgress:0.75 withCompletion:^(BOOL animationFinished) {
            
        }];
    }];
    [self _buttonTitle:@"播放第4个,是失败" handler:^(UIButton * _Nonnull btn) {
        @strongify(animationView)
        [animationView playFromProgress:0.75 toProgress:1.0 withCompletion:^(BOOL animationFinished) {
            
        }];
    }];
    
    NSArray<NSString *> *array = @[
        @"lf20_loading_all",
        @"lf20_loading_failure",
        @"lf20_loading_success",
        @"lf20_loading",
        @"46472-lurking-cat",
        @"Edit",
        @"EmptyStatus",
        @"HappyBirthday",
        @"Loading",
        @"LottieLogo",
        @"Play-Paus",
        @"RectComp",
        @"RefreshFooterAnim",
        @"RefreshHeaderAnim",
        @"Switch",
        @"vcTransition1",
        @"vcTransition2",
        @"lf20_imvcfu5s",
        @"newAnimation",
        @"lf20_4dkca9bw",
    ];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self _titlelabel:obj];
        
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:obj];
        animationView.contentMode = UIViewContentModeScaleAspectFill;
        [self.containerView addSubview:animationView];
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.width.height.mas_equalTo(200);
            make.centerX.mas_equalTo(0);
        }];
//        [animationView play];
//        animationView.loopAnimation = YES;
        self.bottomAttribute = animationView.mas_bottom;
        
        
        [self _buttonTitle:@"播放" handler:^(UIButton * _Nonnull btn) {
            @strongify(animationView)
            [animationView play];
        }];
        
    }];
    
    // 这里放最后一个view的底部
    [self _lastLoadBottomAttribute];
    
}

@end
