//
//  MyTableViewController.m
//  AXiOSKit
//
//  Created by liuweixing on 16/5/26.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXTableViewController.h"
#import "AXiOSKit.h"
@interface AXTableViewController ()

@end

@implementation AXTableViewController

+(AXNavigationController *)navigationVC{
    AXNavigationController *myVC = [[self alloc]init];
    AXNavigationController *nav = [[AXNavigationController alloc]initWithRootViewController:myVC];
    return nav;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView ax_footerViewZero];;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}
- (void)dealloc{
    
    axLong_dealloc;
}

@end
