//
//  AXCollectionViewController.m
//  AXTools
//
//  Created by Mole Developer on 16/5/26.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXCollectionViewController.h"

@interface AXCollectionViewController ()


@end

@implementation AXCollectionViewController


+(AXNaviC *)navigationVC{
    AXNaviC *myVC = [[self alloc]init];
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


@end
