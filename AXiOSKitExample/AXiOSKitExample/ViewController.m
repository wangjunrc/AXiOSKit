//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AAViewController.h"
#import "AXPayVC.h"
#import "AXDateVC.h"
#import "FBLPromises.h"
#import "UIViewController+AXNavBarConfig.h"

#import "FBKVOController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic,strong)CAEmitterLayer *rainLayer;
@property(nonatomic, strong)CALayer *moveLayer;
@property(nonatomic, strong)NSTimer  *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    
    
}

- (IBAction)btnAction1:(id)sender {
    AXWKWebVC *vc = [AXWKWebVC ax_init];
    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"H5.bundle/photo.html" ofType:nil];
    [self ax_pushVC:vc];
    
}
@end
