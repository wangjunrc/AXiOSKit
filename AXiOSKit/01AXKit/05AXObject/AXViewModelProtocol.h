//
//  AXViewModelProtocol.h
//  AXKit
//
//  Created by liuweixing on 2018/11/13.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITableViewCell;
@class UIView;
@class NSIndexPath;

NS_ASSUME_NONNULL_BEGIN

@protocol AXViewModelProtocol <NSObject>

@optional

- (void)ax_viewModelWithCell:(UITableViewCell *)cell value:(id)value;

+ (void)ax_viewModelWithCell:(UITableViewCell *)cell value:(id)value;


- (void)ax_viewModelWithCell:(UITableViewCell *)cell value:(id)value indexPath:(NSIndexPath *)indexPath;

+ (void)ax_viewModelWithCell:(UITableViewCell *)cell value:(id)value indexPath:(NSIndexPath *)indexPath;


- (void)ax_viewModelWithCell:(UITableViewCell * )cell title:(NSString *)title value:(id)value;

+ (void)ax_viewModelWithCell:(UITableViewCell * )cell title:(NSString *)title value:(id)value;


- (void)ax_viewModelWithCell:(UITableViewCell *)cell title:(NSString *)title value:(id)value indexPath:(NSIndexPath *)indexPath;

+ (void)ax_viewModelWithCell:(UITableViewCell *)cell title:(NSString *)title value:(id)value indexPath:(NSIndexPath *)indexPath;


- (void)ax_viewModelWithHeadView:(UIView *)headView value:(id)value;

+ (void)ax_viewModelWithHeadView:(UIView *)headView value:(id)value;


- (void)ax_viewModelWithFootView:(UIView *)footView value:(id)value;

+ (void)ax_viewModelWithFootView:(UIView *)footView value:(id)value;

@end

NS_ASSUME_NONNULL_END
