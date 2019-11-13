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
    
    
         
    self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.redColor darkStyle:UIColor.greenColor];
   
    
    
   
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:view1];
    view1.backgroundColor = UIColor.redColor;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
       [self.view addSubview:view2];
    view2.backgroundColor = UIColor.systemRedColor;
    
    
}

- (IBAction)btnAction1:(id)sender {
//    AXWKWebVC *vc = [AXWKWebVC ax_init];
//    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"H5.bundle/photo.html" ofType:nil];
//    [self ax_pushVC:vc];
   
    [self ax_showAlertByTitle:@"A"];
    
//    if (@available(iOS 13.0, *)) {
//
//        if ( self.overrideUserInterfaceStyle == UIUserInterfaceStyleLight) {
//            self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//        }else{
//            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//        }
//    }
    
    
}

- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {
    [super traitCollectionDidChange: previousTraitCollection];
    
//    if ((self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
//        || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
        // your custom implementation here
        NSLog(@"traitCollectionDidChange");
//    }
    
//    改变当前模式
//
//    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
}

@end
