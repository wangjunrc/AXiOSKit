//
//  MyViewController.m
//  AXTools
//
//  Created by Mole Developer on 16/5/26.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXViewController.h"

@interface AXViewController ()

@end

@implementation AXViewController

+(AXNaviC *)navigationVC{
    
    AXViewController *myVC = [[self alloc]init];
    AXNaviC *nav = [[AXNaviC alloc]initWithRootViewController:myVC];
    return nav;
}

- (void)setShowDisItem:(BOOL)showDisItem{
    _showDisItem = showDisItem;
    if (self.showDisItem) {
        self.navigationItem.leftBarButtonItem =[[ UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(setButtonEvests:)];
    }
}
-(void)setButtonEvests:(UIBarButtonItem *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)loadView{
//    [super loadView];
//    self.view.bounds = [UIScreen mainScreen].bounds;
//}

@end
