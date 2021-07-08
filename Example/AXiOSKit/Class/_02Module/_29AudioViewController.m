//
//  _29AudioViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/13.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_29AudioViewController.h"

@interface _29AudioViewController ()

@end

@implementation _29AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)playAction:(UIButton *)sender {
    sender.selected = !sender.selected;
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
