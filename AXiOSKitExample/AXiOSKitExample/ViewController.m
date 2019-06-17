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
#import "AXChoosePayStyleVC.h"
#import "AXPayVC.h"
#import "NSObject+AXKit.h"
#import "UIGestureRecognizer+AXKit.h"

@protocol SPTDataContainer <NSObject>


@property (nonatomic) BOOL individual;
@property (nonatomic, copy) NSString *fileName;


@end

@interface ViewController ()<SPTDataContainer>

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong) AXViewControllerTransitioningCentre *centre;
@property (weak, nonatomic) IBOutlet UITextField *atf;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

@synthesize fileName;

@synthesize individual;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(UIGestureRecognizer * _Nonnull ges) {
        NSLog(@"ax_gestureRecognizerWithActionBlock");
    }];
    [self.view addGestureRecognizer: tap];
//    [tap ax_addActionBlock:^(UIGestureRecognizer * _Nonnull sender) {
//        NSLog(@"ax_gestureRecognizerWithActionBlock");
//    }];
    
//    [self.view addGestureRecognizer: [UITapGestureRecognizer ax_gestureRecognizerWithActionBlock:^(UIGestureRecognizer * _Nonnull ges) {
//        NSLog(@"ax_gestureRecognizerWithActionBlock");
//    }]];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
//    [btn ax_addActionBlock:^(UIButton * _Nullable button) {
//         NSLog(@"ax_gestureRecognizerWithActionBlock");
//    }];
}

- (BOOL)ax_is_null:(id)obj {
    
     NSLog(@"ax_is_null %d",(NSNull *)obj == [NSNull null]);
    
    
    if (obj == nil) {
         return YES;
    }
        
        
    if ((NSNull *)obj == [NSNull null]) {
        return YES;
    }
    
    if ([obj respondsToSelector:@selector(count)]) {
        if ([(id)obj count] == 0) {
            return YES;
        }
    }
    
    if ([obj respondsToSelector:@selector(length)]) {
        if ([(id)obj length] == 0) {
            return YES;
        }
    }
    
    return NO;
}


- (IBAction)action1:(id)sender {
    
    AATableViewController *vc = [AATableViewController ax_init];
    [self ax_pushVC:vc];
    
}

- (IBAction)action2:(id)sender {
    
    
//    AXChoosePayStyleVC *vc = [[AXChoosePayVC alloc]init];
    AXPayVC *vc = [[AXPayVC alloc]init];
    vc.confirmPayBlock = ^(AXChoosePayModel * _Nonnull payModel) {
        NSLog(@"payModel>> %@",payModel);
    };
    [self ax_showVC:vc];
    
    
    
}
- (IBAction)action3:(id)sender {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testA) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
