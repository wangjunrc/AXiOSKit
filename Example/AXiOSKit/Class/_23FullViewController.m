//
//  _23FullViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/27.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_23FullViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>


@interface _23FullViewController ()

@end

@implementation _23FullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ax_safe_area_insets = %@   %lf",NSStringFromUIEdgeInsets(ax_safe_area_insets()),UIApplication.sharedApplication.statusBarFrame.size.height);
    self.AXListener.hiddenNavigationBar = YES;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
