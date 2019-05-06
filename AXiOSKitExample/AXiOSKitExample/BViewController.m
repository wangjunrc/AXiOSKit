//
//  BViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/5/6.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    UIViewController *vc =[[ UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
