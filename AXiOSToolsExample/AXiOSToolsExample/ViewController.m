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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
        ABViewController *VC = [ABViewController ax_init];
    
    //    NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"AXHTML.bundle/wk_index.html" ofType:nil];
    
        VC.loadHTMLFilePath = [[NSBundle ax_currentBundleWithName:@"AXHTML"]pathForResource:@"index.html" ofType:nil];
    
        [self.navigationController pushViewController:VC animated:YES];
}

@end
