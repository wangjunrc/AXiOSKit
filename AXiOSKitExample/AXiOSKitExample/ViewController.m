//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import <AXiOSKit/AXiOSKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnAction1:(id)sender {
    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"H5.bundle/index.html" ofType:nil];
    NSLog(@"vc.loadHTMLFilePath>> %@",vc.loadHTMLFilePath);
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
