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
    
    [btn1 ax_addActionBlock:^(UIButton * _Nullable button) {
        [self.viewBottomConstraint uninstall];
        
        [view1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-30);
                
            }];
            
            [view1.superview layoutIfNeeded];
        }];
        
        
        
    }];
    
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
