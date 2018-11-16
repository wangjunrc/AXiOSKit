//
//  AXSetmodelProtocol.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AXSetmodelProtocol <NSObject>

@optional
- (void)ax_setCellWithModel:(id)model;

- (void)ax_setCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

- (void)ax_setCellWithModel:(id)model title:(NSString *)title;

- (void)ax_setCellWithModel:(id)model title:(NSString *)title indexPath:(NSIndexPath *)indexPath;

- (void)ax_setHeadViewWithModel:(id)model;

- (void)ax_setFootViewWithModel:(id)model;


+(void)ax_setCell:(id )cell model:(id)model;

+(void)ax_setCell:(id)cell model:(id)model indexPath:(NSIndexPath *)indexPath;

+(void)ax_setCell:(id )cell title:(NSString *)title model:(id)model;

+(void)ax_setCell:(id)cell title:(NSString *)title model:(id)model indexPath:(NSIndexPath *)indexPath;

+(void)ax_setHeadView:(UIView *)view model:(id)model;

+(void)ax_setFootView:(UIView *)view model:(id)model;


@end
