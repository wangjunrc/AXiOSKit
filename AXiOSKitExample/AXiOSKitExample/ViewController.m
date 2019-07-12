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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
}

- (IBAction)btnAction1:(id)sender {
    
    [self ax_showCameraWithEditing:YES block:^(UIImage *originalImage, UIImage *editedImage) {
       [self ax_saveImageToPhotos:originalImage];
    }];
    
}

@end
