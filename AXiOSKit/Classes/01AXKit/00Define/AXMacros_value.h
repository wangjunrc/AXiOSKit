//
//  AXMacros_value.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#ifndef AXMacros_value_h
#define AXMacros_value_h

/**
 tableViewCell 自适应高度DataSource
 */
#define AX_tableViewCell_height_Automatic \
- (CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{\
return UITableViewAutomaticDimension;\
}\
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{\
return UITableViewAutomaticDimension;\
}\

#endif /* AXMacros_value_h */
