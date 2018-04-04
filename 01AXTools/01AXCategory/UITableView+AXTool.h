//
//  UITableView+AXTool.h
//  AXTools
//
//  Created by liuweixing on 16/8/23.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (AXTool)

- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier;

-(void)ax_footerViewZero;

@end
