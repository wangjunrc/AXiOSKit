//
//  _01ContentViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_01ContentViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>

#import <SDWebImage/UIImageView+WebCache.h>
@interface _01ContentViewController ()
@property (nonatomic, strong) MASConstraint *viewBottomConstraint;

@end

@implementation _01ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    CGFloat width = 100;
    
    UIView *view1 = [[UIView alloc]init];
    [self.view addSubview:view1];
    view1.backgroundColor = UIColor.orangeColor;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.equalTo(btn1.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(100);
        
        self.viewBottomConstraint = make.width.mas_equalTo(width);
    }];
    
    
    __block typeof(width)weakWwidth = width;
    
    //    [btn1 ax_addActionBlock:^(UIButton * _Nullable button) {
    //
    //
    //        [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
    ////            make.left.mas_equalTo(30);
    ////            make.top.equalTo(btn1.mas_bottom).mas_offset(50);
    ////            make.height.mas_equalTo(100);
    //
    //            if (weakWwidth ==100) {
    //                weakWwidth =200;
    //            }else{
    //                weakWwidth = 100;
    //            }
    //            NSLog(@"weakWwidth %lf",weakWwidth);
    //            make.width.mas_equalTo(weakWwidth);
    //        }];
    //    }];
    
    __weak typeof(self) weakSelf = self;
    [btn1 ax_addActionBlock:^(UIButton * _Nullable button) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewBottomConstraint uninstall];
        
        [view1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-30);
                
            }];
            
            [view1.superview layoutIfNeeded];
        }];
        
        
        
    }];
    
//
//    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
//    view.image = [UIImage imageNamed:@"exporte"];
//    view.backgroundColor=[UIColor yellowColor];
//    view.layer.masksToBounds=YES;
//    view.layer.cornerRadius=10;
//    view.layer.borderWidth = 1.5;
//    view.layer.borderColor = [UIColor redColor].CGColor;;
////    view.layer.shadowColor=[UIColor redColor].CGColor;
////    view.layer.shadowOffset=CGSizeMake(10, 10);
////    view.layer.shadowOpacity=0.5;
////    view.layer.shadowRadius=5;
//    [self.view addSubview:view];
//
//
//    [view  ax_shadowWith:UIColor.redColor];
//
//
//    NSMutableArray<UIView *> *aryy = [NSMutableArray array];
//    UIView * _imgViewBgView = [UIView.alloc init];
//    _imgViewBgView.layer.cornerRadius = 6;
//    _imgViewBgView.backgroundColor = UIColor.blueColor;
////    _imgViewBgView.axis = UILayoutConstraintAxisHorizontal;
////    _imgViewBgView.alignment = UIStackViewAlignmentFill;
////    _imgViewBgView.spacing = 10;
////    _imgViewBgView.distribution = UIStackViewDistributionEqualCentering;
//    [self.view addSubview:_imgViewBgView];
//    [_imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(20);
//        make.right.bottom.mas_offset(-20);
////        make.height.mas_equalTo(300);
//    }];
//
//
//    for(int i=0;i<3;i++){
//        UIImageView *imgView = [UIImageView.alloc init];
//        imgView.layer.cornerRadius = 6;
//        [_imgViewBgView addSubview:imgView];
//        [aryy addObject:imgView];
//        if (i==0) {
//            imgView.backgroundColor = UIColor.greenColor;
//        }else  if (i==1){
//
//            imgView.backgroundColor = UIColor.orangeColor;
//        }else {
//
//            imgView.backgroundColor = UIColor.redColor;
//        }
//    }
//
//
//    [aryy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
////    [aryy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
//
//    [aryy mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
////        make.height.mas_equalTo(150);
//    }];
//
//    [_imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.equalTo(aryy.firstObject.mas_bottom);
//    }];
//
    
//    UIView *bgView = [UIView.alloc init];
//    [self.view addSubview:bgView];
//    bgView.backgroundColor = UIColor.greenColor;
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_offset(100);
//        make.right.mas_offset(-100);
//
//    }];
//
//
//
//    UIImageView *contentImageView = UIImageView.alloc.init;
//    [bgView addSubview:contentImageView];
//    contentImageView.layer.cornerRadius = 6;
//    contentImageView.layer.masksToBounds = YES;
//    contentImageView.contentMode = 0;
//    contentImageView.backgroundColor = UIColor.redColor;
//    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_offset(20);
//        make.right.mas_offset(-20);
////        make.width.equalTo(self.bgView).dividedBy(3);
//        make.bottom.mas_offset(-20);
//
//    }];
//
//    [contentImageView sd_setImageWithURL:[NSURL URLWithString:@"https://bing.ioliu.cn/v1/rand?key=b0&w=200&h=300"] placeholderImage:[UIImage imageNamed:@"hot_load"]];
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
