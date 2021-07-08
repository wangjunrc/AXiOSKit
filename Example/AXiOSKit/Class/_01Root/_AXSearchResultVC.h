//
//  _AXSearchResultVC.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/7.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_AXCellItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface _AXSearchResultVC : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray<_AXCellItem*> *filterArray;

@property(nonatomic, copy) void(^searchTextBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END
