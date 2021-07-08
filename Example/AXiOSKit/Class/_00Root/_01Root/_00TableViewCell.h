//
//  _00TableViewCell.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CellBorderStyle) {
    CellBorderStyleNoRound = 0,
    CellBorderStyleTopRound,
    CellBorderStyleBottomRound,
    CellBorderStyleAllRound,
};


@interface _00TableViewCell : UITableViewCell

@property(strong, nonatomic)  UILabel *titleLabel;
@property(strong, nonatomic)  UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
