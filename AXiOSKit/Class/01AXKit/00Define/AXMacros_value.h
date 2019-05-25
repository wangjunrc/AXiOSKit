//
//  AXMacros_value.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#ifndef AXMacros_value_h
#define AXMacros_value_h

///**
// 状态栏高度
// */
//#define AX_View_Status_Height [UIApplication sharedApplication].statusBarFrame.size.height
//
///**
// 状态栏高度 和 nav 高度 普通 64 ,x 88
// */
//#define AX_View_Top_Height  ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height)
//
///**
// 安全区域 insets
// */
//#define AXViewSafeAreInsets(view) \
//({UIEdgeInsets insets;\
//if(@available(iOS 11.0, *)) {\
//insets = view.safeAreaInsets;\
//} else {\
//    insets = UIEdgeInsetsZero;\
//} insets;\
//})\
//
//
///**
// 安全区域 bottom
// */
//#define AXViewSafeAreBottom(view) AXViewSafeAreInsets(view).bottom
//
///**
// 安全区域 top 状态栏高度 和 nav 高度 普通 64 ,x 88
// */
//#define AXViewSafeAreTop(view) AXViewSafeAreInsets(view).top

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


#define AX_NIB(name) [UINib nibWithNibName:name bundle:[NSBundle bundleForClass:self.class]]


#endif /* AXMacros_value_h */
