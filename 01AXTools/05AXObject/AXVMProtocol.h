//
//  AXVMProtocol.h
//  ZBP2P
//
//  Created by liuweixing on 2017/2/8.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AXVMProtocol <NSObject>

@optional

+(void)setupCell:(id )cell model:(id)model;

+(void)setupCell:(id)cell model:(id)model indexPath:(NSIndexPath *)indexPath;

+(void)setupCell:(id )cell title:(NSString *)title model:(id)model;

+(void)setupCell:(id)cell title:(NSString *)title model:(id)model indexPath:(NSIndexPath *)indexPath;

+(void)setupHeadView:(UIView *)view model:(id)model;

+(void)setupFootView:(UIView *)view model:(id)model;

@end
