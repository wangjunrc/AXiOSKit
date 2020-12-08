//
//  _00BaseViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/8.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_00BaseViewController.h"

@interface _00BaseViewController ()

@end

@implementation _00BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    UIScrollView *scrollView = [UIScrollView.alloc init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 2.给scrollView添加一个containerView
    UIView *containerView = [UIView.alloc init];
    containerView.backgroundColor = UIColor.whiteColor;
    self.containerView = containerView;
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView); // 需要设置宽度和scrollview宽度一样
    }];
    
    self.bottomAttribute = self.containerView.mas_top;
    
}

-(MASViewAttribute *)_p00ButtonTopView:(MASViewAttribute *)viewBottomAttribute title:(NSString *)title handler:(void(^)(void))handler {
    if (title.length==0) {
        title = @"title";
    }
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:title];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(500);
    }];
    /// 按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        if (handler) {
            handler();
        }
    }];
    viewBottomAttribute =  btn.mas_bottom;
    return viewBottomAttribute;
}


-(void )_p00ButtonTitle:(NSString *)title handler:(void(^)(void))handler {
    if (title.length==0) {
        title = @"title";
    }
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:title];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    /// 按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        if (handler) {
            handler();
        }
    }];
    self.bottomAttribute =  btn.mas_bottom;
}


-(void)_loadBottomAttribute {
    
    // 这里放最后一个view的底部
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomAttribute).mas_equalTo(100);
    }];
}

@end
