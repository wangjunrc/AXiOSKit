//
//  _AXCellItem.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _AXCellItem : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) NSString *imgName;
@property(nonatomic, copy) void(^action)(void);

@end


@interface NSMutableArray (AXCellItem)

- (void)addTitle:(NSString *)title
          detail:(NSString  * _Nullable )detail
          action:(void(^)(_AXCellItem *option))action;

- (void)ax_addItem:(void (^)(_AXCellItem *item))add
            action:(void (^)(_AXCellItem *item))action;


@end



NS_ASSUME_NONNULL_END
