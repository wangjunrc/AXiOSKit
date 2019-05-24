//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSKit.h"
#import "WebJSHandler.h"
#import "AXChoosePayVC.h"
#import "AXDateVC.h"
#import "AAAViewController.h"
#import "SolveCrash.h"
#import "AXHelper.h"
#import "AXAlertCentreAnimation.h"
#import "BViewController.h"
#import "AXViewControllerTransitioningCentre.h"

@protocol SPTDataContainer <NSObject>


@property (nonatomic) BOOL individual;
@property (nonatomic, copy) NSString *fileName;

@end

@interface ViewController ()<SPTDataContainer>

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong) AXViewControllerTransitioningCentre *centre;
@end

@implementation ViewController

@synthesize fileName;

@synthesize individual;

- (AXViewControllerTransitioningCentre *)centre {
    if (!_centre) {
        _centre = [[AXViewControllerTransitioningCentre alloc]init];
    }
    return _centre;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSLog(@"fileName>> %@",self.fileName);;
    
    self.fileName = @"AAAA";
     NSLog(@"fileName>> %@",self.fileName);;
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    self.btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).equalTo(@120);
         make.left.equalTo(self.view).equalTo(@20);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(100);
}];
    
    
    
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    
    
}
- (IBAction)action1:(id)sender {
    
//    [NSObject becomeActive];
    
//      [[SolveCrash sharedInstance] becomeActive];
    
//    AXChoosePayVC *vc = [[AXChoosePayVC alloc]init];
//    [self ax_showVC:vc];
    
    
//    [self.view layoutIfNeeded];
//    NSLog(@"action1");
    
//    BViewController *vc = [BViewController ax_init];
//     vc.modalPresentationStyle = UIModalPresentationCustom;
//    vc.transitioningDelegate = self.centre;
//    [self presentViewController:vc animated:YES completion:nil];
    
    
    AXDateVC *vc = [AXDateVC ax_init];
    [self ax_showVC:vc];
    
//        AAAViewController *vc = [AAAViewController ax_init];
//        [self ax_showVC:vc];
//
    
//    [self ax_showAlertByTitle:@"AAAA"];
}

- (IBAction)action2:(id)sender {
    
    NSLog(@"action2");
    
    
    [self.view setNeedsLayout];
     [self.view layoutIfNeeded];
     NSLog(@"action22222");
}
- (IBAction)action3:(id)sender {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testA) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
