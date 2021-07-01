//
//  AXTestViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/6/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXTestViewController.h"

@interface AXTestViewController ()

@end

@implementation AXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)addA:(NSInteger)a andB:(NSInteger)b
{
    NSLog(@"测试=================");
    
    CGSize size1 = {.height = 30,.width = 20};
    
    NSLog(@"size1=%@",NSStringFromCGSize(size1));
    
    CGSize size2 = {21,31};
    NSLog(@"size2=%@",NSStringFromCGSize(size2));
    
    return a+b;
}

@end
