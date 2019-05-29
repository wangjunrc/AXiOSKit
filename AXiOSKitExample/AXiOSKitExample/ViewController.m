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
#import "HistogramView.h"
#import "UITextView+AXAction.h"
#import "AATableViewController.h"
#import "UITextField+AXAction.h"

@protocol SPTDataContainer <NSObject>


@property (nonatomic) BOOL individual;
@property (nonatomic, copy) NSString *fileName;


@end

@interface ViewController ()<SPTDataContainer>

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong) AXViewControllerTransitioningCentre *centre;
@property (weak, nonatomic) IBOutlet UITextField *atf;
@end

@implementation ViewController

@synthesize fileName;

@synthesize individual;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.atf.ax_keyboardObserve.containerView = self.view;
    
}
- (IBAction)action1:(id)sender {
    
    AATableViewController *vc = [AATableViewController ax_init];
    [self ax_pushVC:vc];
    
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
