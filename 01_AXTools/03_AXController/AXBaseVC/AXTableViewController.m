//
//  MyTableViewController.m
//  AXTools
//
//  Created by Mole Developer on 16/5/26.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXTableViewController.h"

@interface AXTableViewController ()

@end

@implementation AXTableViewController

+(AXNaviC *)navigationVC{
    AXNaviC *myVC = [[self alloc]init];
    AXNaviC *nav = [[AXNaviC alloc]initWithRootViewController:myVC];
    return nav;
}

@end
