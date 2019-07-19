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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:label];
    label.backgroundColor =UIColor.orangeColor;
    label.text =@"akc";
    label.ax_longPressCopyMenu = YES;;
    
}

- (IBAction)btnAction1:(id)sender {
    
//    [self ax_showCameraWithEditing:NO block:^(UIImage *originalImage, UIImage *editedImage) {
////       [self ax_saveImageToPhotos:originalImage];
////         [self ax_saveImageToLibrary:originalImage];
//
//    }];
    
    
//    AXPayVC *vc = [[AXPayVC alloc]init];
//    [self ax_showVC:vc];
    
    AXDateVC *vc = [[AXDateVC alloc]init];
    [self ax_showVC:vc];
    
    
    
//      AXChoosePayVC *vc = [[AXChoosePayVC alloc]init];
//    [self ax_pushVC:vc];
}

@end
