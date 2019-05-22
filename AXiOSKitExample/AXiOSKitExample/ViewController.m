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


@interface ViewController ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [[AXHelper alloc]init].isiPad(^{
        NSLog(@"isiPad");

    }).isiPhone(^{
         NSLog(@"isiPhone");
    }).isDebug(^{
         NSLog(@"isDebug");
    }).isRelease(^{
         NSLog(@"isRelease");
    });
    
    
    
    
}

- (IBAction)action1:(id)sender {
    
//    [NSObject becomeActive];
    
      [[SolveCrash sharedInstance] becomeActive];
}

- (IBAction)action2:(id)sender {
    
    NSLog(@"action2");
    
}
- (IBAction)action3:(id)sender {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testA) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
