//
//  AAViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"
#import "AXiOSTools.h"
#import "UITextField+AXTool.h"

#import "UITextField+AXAction.h"

@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ACViewController *vc =[ACViewController ax_init];
//    vc.vc = self;
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    axLong_dealloc;
}
@end
