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
    
    NSString *str =
    [NSBundle.ax_mainBundle localizedStringForKey:@"ax.cancel"
                                            value:@""
                                            table:@"AXKitLocalizedString"];
     NSLog(@"NSBundle.ax_mainBundle>> %@",NSBundle.mainBundle);
     NSLog(@"NSBundle.ax_mainBundle>> %@",NSBundle.ax_mainBundle);
        NSLog(@"str>> %@",str);
    
//    if (str.length == 0) {
//        str = NSLocalizedStringFromTable(key, @"AXKitLocalizedString", @"");
//    }
    
    
    NSString *str2 = AXKitLocalizedString(@"ax.cancel");
    
    NSLog(@"str>> %@",str2);
    
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
