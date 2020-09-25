//
//  DLCompanyNewsMoreSmallPictureCell.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 3个小图, 上中下 文字 > 图片 > 时间
@interface DLCompanyNewsMoreSmallPictureCell : UITableViewCell

/// 背景
@property(nonatomic, strong) UIView *bgView;

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

/// 日期
@property(nonatomic, strong) UILabel *dateLabel;

/// 图片 背景
@property(nonatomic, strong) UIView *imgViewBgView;

/// 图片 Array
@property(nonatomic, strong) NSArray<UIImageView *> *imageViewArray;

@property(nonatomic,readonly, class) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
