//
//  _AXThemeCell.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_AXCellItem.h"
#import <AXiOSKit/UITableViewCell+AXKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface _AXThemeCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) _AXCellItem *option;


@end

NS_ASSUME_NONNULL_END
