//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//




#import "ViewController.h"

#import "ABViewController.h"
#import "AXiOSTools.h"

#import "AAViewController.h"
#import "AView.h"
#import "AView.h"

@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    AView *aview = [[AView alloc]init];
    [self.view addSubview:aview];
    aview.backgroundColor = [UIColor grayColor];
    
    [aview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(200);
         make.left.mas_equalTo(20);
         make.size.mas_equalTo(CGSizeMake(200, 200));
        
    }];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AAViewController *avc = [[AAViewController alloc]init];
//    avc.vc = self;
    avc.did = ^{
        self.view.backgroundColor = [UIColor redColor];
    };
    self.avc = avc;
    [self.navigationController pushViewController:avc animated:YES];
    
}
- (IBAction)btnAction:(id)sender {
    
    [self ax_revolveOrientation:UIInterfaceOrientationLandscapeRight];
    
}



@end
