//
//  AXViewModel.h
//  ZBP2P
//
//  Created by liuweixing on 2016/12/14.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXToolsHeader.h"
@interface AXViewModel : NSObject

+(void)setupCell:(id )cell model:(id)model;

+(void)setupCell:(id )cell title:(NSString *)title model:(id)model;


+(void)setupCell:(id)cell model:(id)model indexPath:(NSIndexPath *)indexPath;

+(void)setupCell:(id)cell title:(NSString *)title model:(id)model indexPath:(NSIndexPath *)indexPath;


+(void)setupHeadView:(UIView *)view model:(id)model;

+(void)setupFootView:(UIView *)view model:(id)model;

@end
