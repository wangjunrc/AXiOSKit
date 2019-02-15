//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "ABViewController.h"
#import "AXiOSTools.h"

#import "AAViewController.h"

@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AAViewController *avc = [[AAViewController alloc]init];
//    avc.vc = self;
    avc.did = ^{
        self.view.backgroundColor = [UIColor redColor];
    };
    self.avc = avc;
    [self.navigationController pushViewController:avc animated:YES];
    
}
- (IBAction)btnAction:(id)sender {
    self.avc = nil;
}



@end
