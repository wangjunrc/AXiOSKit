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
        make.top.left.right.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];


    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"instruction.jpg"]];
    self.imageView.contentMode = UIViewContentModeTop;
    [self.scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.left.right.equalTo(self.scrollView);
//        make.width.equalTo(self.view);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView);
    }];
    
}


@end
