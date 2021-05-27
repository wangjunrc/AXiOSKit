//
//  UITableViewCell+AXKit.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (AXKit)

+ (void)ax_registerCellWithTableView:(UITableView *)tableView;

+ (void)ax_registerNibCellWithTableView:(UITableView *)tableView;

+ (__kindof UITableViewCell *)ax_dequeueCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic,readonly, class) NSString *ax_identifier;

@end

NS_ASSUME_NONNULL_END
