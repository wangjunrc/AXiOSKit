//
//  _19ScrollContentViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/17.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_19ScrollContentViewController.h"
#import <Masonry/Masonry.h>

@interface _19ScrollContentViewController ()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *containerView;
@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation _19ScrollContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = UIColor.greenColor;

    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

    // 2.给scrollView添加一个containerView
    self.containerView = UIView.alloc.init;
    self.containerView.backgroundColor = UIColor.redColor;
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    UIImage *img = [UIImage imageNamed:@"instruction.jpg"];
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"instruction.jpg"]];
//    [self.imageView  setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.imageView.clipsToBounds  = YES;
    [self.containerView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.containerView);
    }];
    
    
    // 3.所有的子控件都放到containerView里面, 在最后一个子控件后设置约束
   [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self.imageView.mas_bottom);// 这里放最后一个view的底部
   }];
    
}


@end
