//
//  UITableView+AXTool.h
//  AXTools
//
//  Created by Mole Developer on 16/8/23.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXNoMessageView.h"
#import "AXNoContentView.h"
@interface UITableView (AXTool)

- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier;

@end
