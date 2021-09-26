//
//  _17OtherShareViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_17OtherShareViewController.h"
#import "AXUserSwiftImport.h"
#import "AXSocialShareViewController.h"
@interface _17OtherShareViewController ()

@end

@implementation _17OtherShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第三方分享";
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"MonkeyKing分享" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXSocialShareViewController *vc = AXSocialShareViewController.alloc.init;
        [strongSelf ax_showVC:vc];
    }];
    
    [self _lastLoadBottomAttribute];
}

@end
