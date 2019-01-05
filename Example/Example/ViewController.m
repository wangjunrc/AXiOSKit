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
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:iv];
    iv.backgroundColor = [UIColor redColor];
    iv.image = [UIImage imageNamed:@"ax_emptyData"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AXDateVC *vc = [[AXDateVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.loadHTMLString = @"axwkWebView.html";
    [self ax_showVC:vc];
}
@end
