//
//  UITableView+AXTool.m
//  AXTools
//
//  Created by liuweixing on 16/8/23.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UITableView+AXTool.h"

@implementation UITableView (AXTool)

- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier{
    [self registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:identifier];
}

-(void)ax_footerViewZero{
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

@end
