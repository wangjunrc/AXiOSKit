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
    NSArray<NSString *> *array = @[
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
    ];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:obj];
        animationView.contentMode = UIViewContentModeScaleAspectFill;
        [self.containerView addSubview:animationView];
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.width.height.mas_equalTo(200);
            make.centerX.mas_equalTo(0);
        }];
        [animationView play];
        animationView.loopAnimation = YES;
        self.bottomAttribute = animationView.mas_bottom;
        
    }];
    
  
    
    
    
    
    
    // 这里放最后一个view的底部
    [self _loadBottomAttribute];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
