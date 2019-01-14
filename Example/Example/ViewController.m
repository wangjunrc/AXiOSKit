//
//  ViewController.m
//  Example
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
//     NSLog(@"NSBundle.ax_mainBundle>> %@",NSBundle.ax_mainBundle);
//     NSLog(@"NSBundle.ax_mainBundle>> %@",NSBundle.mainBundle);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    AXDateVC *dateVC = [AXDateVC ax_init];
//    [self ax_showVC:dateVC];
//
//    return;
    
    
    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
//    vc.loadURLString = @"https://www.baidu.com/";
    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"AXHTML.bundle/wk_index.html" ofType:nil];
//     vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"ax_test.html" ofType:nil];
     NSLog(@"vc.loadHTMLFilePath>> %@",vc.loadHTMLFilePath);
//     vc.loadHTMLFilePath = [NSBundle.ax_mainBundle pathForResource:@"ax_test2.html" ofType:nil];
//    NSLog(@"vc.loadHTMLFilePath>> %@",vc.loadHTMLFilePath);
    
    
}
@end
