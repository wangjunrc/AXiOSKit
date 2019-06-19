//
//  AAViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"

@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    
    NSLog(@" [self.navigationController.viewControllers.firstObject isEqual:self] %d",[self.navigationController.viewControllers.firstObject isEqual:self] && self.navigationController);
    
    NSLog(@"self.presentedViewController>> %@",self.parentViewController);
//    NSLog(@"self.presentedViewController>> %d",self.parentViewController);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
