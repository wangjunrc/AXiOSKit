//
//  AXMacros_value.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#ifndef AXMacros_value_h
#define AXMacros_value_h

/*
 基本数据类型 变成string
 */
#define assignToString(assign) @(assign).description

/**
 状态栏高度 和 nav 高度 普通 64 ,x 88
 */
#define AX_View_Top_Height  [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height


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


/**
 * Localizable.strings  标准名称 国际化文件
 */
#define  AXNSLocalizedString(key) NSLocalizedString(key,nil)

/**
 * 自定义国际化文件
 */
#define  AXToolsLocalizedString(key) NSLocalizedStringFromTable(key,@"AXToolsLocalizedString", @"")



#endif /* AXMacros_value_h */
