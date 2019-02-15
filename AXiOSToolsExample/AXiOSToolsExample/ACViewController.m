//
//  ACViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ACViewController.h"
#import "AXiOSTools.h"
@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor orangeColor];
     self.vc.view.backgroundColor = [UIColor orangeColor];
}


- (void)dealloc{
    axLong_dealloc;
}

@end
