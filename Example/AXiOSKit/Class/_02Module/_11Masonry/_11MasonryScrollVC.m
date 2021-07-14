//
//  _11MasonryScrollVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/14.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_11MasonryScrollVC.h"
@import Masonry;

@interface _11MasonryScrollVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;//子视图容器
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation _11MasonryScrollVC

-(void)viewDidLoad {
   [super viewDidLoad];
   [self addSubView];
   [self layoutAllSubView];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
//    UIImageView *imageView = UIImageView.alloc.init;
//
//    [self.view addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"西瓜"];
//    imageView.backgroundColor = UIColor.greenColor;
//    imageView.contentMode = 1;
//
//    [imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
//
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_offset(100);
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(300);
//    }];
}

- (void)addSubView
{
   [self.view addSubview:self.scrollView];
   [self.scrollView addSubview:self.contentView];
   [self.contentView addSubview:self.redView];
   [self.contentView addSubview:self.yellowView];
   [self.contentView addSubview:self.purpleView];
   [self.contentView addSubview:self.blueView];
}

//layoutSubView原本方法与系统方法太像导致某些误解，现在更正
- (void)layoutAllSubView
{
   [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.bottom.right.mas_equalTo(0);
   }];
   
   [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//       ## 法1: 代码可以 《|》 xib 会报约束不够
//        make.top.bottom.mas_equalTo(0);
//        make.width.equalTo(self.scrollView);
       
//       ## 法2:
       make.top.left.bottom.right.mas_equalTo(0);
       make.centerX.equalTo(self.scrollView);//不能加 centerY 不然算不准，xib 可以加(不加会报缺少约束，但是设置子控件约束完之后就不报错了)；原因我猜是：它都是可以向四方延伸，它不能确定
   }];
   
   [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(30);
       make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
       make.height.mas_equalTo(300);
   }];
   
   [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.redView.mas_bottom).offset(30);
       make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
       make.height.mas_equalTo(400);
   }];
   
   [self.purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.yellowView.mas_bottom).offset(30);
       make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
       make.height.mas_equalTo(500);
   }];
   

   //注意⚠️：最后一个 view 要多设置一个底部约束，这个约束是，最后一个 view 和滚动范围最底下的间距
   [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.purpleView.mas_bottom).offset(30);
       make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
       make.height.mas_equalTo(600);
       
      //注意⚠️ : 最后一个 view 和滚动范围最底下的间距
//       make.bottom.mas_equalTo(-30);
   }];
   
    
    UIImageView *imageView = UIImageView.alloc.init;
    
    [self.contentView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"西瓜"];
    
    
    [imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.blueView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(200);
        
    }];
    
    
    
   
}

#pragma mark - getter
- (UIScrollView *)scrollView
{
   if (_scrollView == nil) {
       UIScrollView *scrollView = [[UIScrollView alloc] init];
       scrollView.backgroundColor = [UIColor grayColor];
       _scrollView = scrollView;
   }
   return _scrollView;
}

- (UIView *)contentView
{
   if (_contentView == nil) {
       UIView *av = [[UIView alloc] init];
       _contentView = av;
   }
   return _contentView;
}

- (UIView *)redView
{
   if (_redView == nil) {
       UIView *av = [[UIView alloc] init];
       av.backgroundColor = [UIColor redColor];
       _redView = av;
   }
   return _redView;
}

- (UIView *)yellowView
{
   if (_yellowView == nil) {
       UIView *av = [[UIView alloc] init];
       av.backgroundColor = [UIColor yellowColor];
       _yellowView = av;
   }
   return _yellowView;
}

- (UIView *)purpleView
{
   if (_purpleView == nil) {
       UIView *av = [[UIView alloc] init];
       av.backgroundColor = [UIColor purpleColor];
       _purpleView = av;
   }
   return _purpleView;
}

- (UIView *)blueView
{
   if (_blueView == nil) {
       UIView *av = [[UIView alloc] init];
       av.backgroundColor = [UIColor blueColor];
       _blueView = av;
   }
   return _blueView;
}

@end
