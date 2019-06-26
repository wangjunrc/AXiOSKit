//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AAViewController.h"
#import <AXiOSKit/NSData+AXKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date1 = [@"2019-01-01 01:59:00" ax_toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date2 = [@"2019-01-02 01:00:00" ax_toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSLog(@">> %ld",[date1 ax_apartDayTo:date2]);
    
    NSLog(@">> %ld",[date1 ax_apartDateComponents:date2].day);
    
}

- (IBAction)btnAction1:(id)sender {
    
//    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
//    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"H5.bundle/index.html" ofType:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc addScriptMessageWithName:@"person" handler:^(NSString * _Nonnull name, id  _Nonnull body) {
//        NSLog(@"body>> %@",body);
//    }];
    
    AXDateVC *vc = [[AXDateVC alloc]init];
    [self ax_showVC:vc];
    
}

@end
