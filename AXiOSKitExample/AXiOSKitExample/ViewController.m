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
//    self.atf.ax_keyboardObserve.containerView = self.view;
    
//    self.label.text = [NSString stringWithFormat:@" %@\\u0020",@"A"];
    
//    self.label.text = @"  AAA\u0020 ";
//    self.label.backgroundColor = [UIColor redColor];
////   self.label.text = [NSString stringWithFormat:@"%@%@",@"aaaaa",@"\u3000"];
//
//    self.label.text = [NSString stringWithFormat:@"\u00A0\u00A0中\u00A0\u00A0"];
//     self.label.text = [NSString stringWithFormat:@"\u3000文\u3000"];
//    self.label.text = [NSString stringWithFormat:@"A\u00A0"];
    
//    和
    
//       self.label.text = [NSString stringWithFormat:@"%@ ",@"aaaaa"];

    id str;
    NSLog(@">>??? %d",ax_is_null(str));
    
//     NSLog(@">>??? %d",[self ax_is_null:str]);
    
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
