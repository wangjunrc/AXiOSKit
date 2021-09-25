//
//  MyViewController.m
//  AXiOSKit
//
//  Created by liuweixing on 16/5/26.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXKitViewController.h"
#import "AXiOSKit.h"
@interface AXKitViewController ()

@end

@implementation AXKitViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self =[super initWithNibName:nibNameOrNil bundle:[NSBundle bundleForClass:self.class]]) {
        
    }
    return self;
}

+(AXNavigationController *)navigationVC{
    
    AXKitViewController *myVC = [[self alloc]init];
    AXNavigationController *nav = [[AXNavigationController alloc]initWithRootViewController:myVC];
    return nav;
}

- (void)setShowDisItem:(BOOL)showDisItem{
    _showDisItem = showDisItem;
    if (self.showDisItem) {
        self.navigationItem.leftBarButtonItem =[[ UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(setButtonEvests:)];
    }
}
- (void)setButtonEvests:(UIBarButtonItem *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)loadView{
//    [super loadView];
//    self.view.bounds = [UIScreen mainScreen].bounds;
//}
- (void)dealloc{
    
    axLong_dealloc;
}

@end
