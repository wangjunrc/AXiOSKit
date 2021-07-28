//
//  _AXCellItem.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_AXCellItem.h"

@implementation _AXCellItem

@end

@implementation NSMutableArray (AXCellItem)


- (void)addTitle:(NSString *)title
          detail:(NSString *)detail
          action:(void(^)(_AXCellItem *option))action {
    
    NSMutableArray *tempArray = self;
    _AXCellItem *item = _AXCellItem.alloc.init;
    [tempArray addObject:item];
    item.title = title;
    item.detail = detail;
    @weakify(item)
    item.action = ^{
        @strongify(item)
        if (action) {
            action(item);
        }
    };
}


- (void)ax_addItem:(void (^)(_AXCellItem *item))add {
    if (add) {
        NSMutableArray *tempArray = self;
        _AXCellItem *item = _AXCellItem.alloc.init;
        add(item);
        [tempArray addObject:item];
    }
}

@end
