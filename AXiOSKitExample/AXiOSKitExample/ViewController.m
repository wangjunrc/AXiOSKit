//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *path = [[NSBundle ax_HTMLBundle] URLForResource:@"index" withExtension:@"html"];
    
    
    AXWKWebVC *web = [[AXWKWebVC alloc]init];
    web.loadURL =path;
    [self.navigationController pushViewController:web animated:YES];
}
@end
