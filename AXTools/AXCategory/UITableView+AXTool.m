//
//  UITableView+AXTool.m
//  AXTools
//
//  Created by Mole Developer on 16/8/23.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "UITableView+AXTool.h"

@implementation UITableView (AXTool)

- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier{
    [self registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:identifier];
}

@end
