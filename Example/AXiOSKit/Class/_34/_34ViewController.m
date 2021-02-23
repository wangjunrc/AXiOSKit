//
//  _34ViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/23.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_34ViewController.h"
#import "CTMediator+NewsActions.h"

@interface _34ViewController ()

@end

@implementation _34ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self _p00ButtonTitle:@"跳转" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIViewController *viewController = [[CTMediator sharedInstance] yt_mediator_newsViewControllerWithParams:@{@"newsID":@"123456"}];
        [strongSelf.navigationController pushViewController:viewController animated:YES];
        
    }];
    
    // 这里放最后一个view的底部
    [self _loadBottomAttribute];
    
}


@end
