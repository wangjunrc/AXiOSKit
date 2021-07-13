//
//  _AXThemeCell.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_11MasonryCell.h"
@import Masonry;

@implementation _11MasonryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI {
    
    self.contentView.backgroundColor = [UIColor colorWithRed:0 green:47.0 blue:167.0 alpha:1];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.logoImgView];
    
    /// 设置内容拥抱优先级
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
   /// 设置内容抗压缩优先级
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    
    [self.detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    // 抗被压缩
    [self.detailLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    self.titleLabel.mas_key = @"图片";
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(10);
        make.width.height.mas_equalTo(60);
    }];
    self.titleLabel.mas_key = @"标题";
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView.mas_bottom);
        make.left.equalTo(self.logoImgView.mas_left);
        make.right.equalTo(self.logoImgView.mas_right);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-20);
        
    }];
    self.detailLabel.mas_key = @"详情";
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.logoImgView.mas_top);
        make.left.equalTo(self.logoImgView.mas_right).mas_offset(20);;
        make.right.equalTo(self.contentView).mas_offset(-10);
        
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-20);
    }];
    
    
}


- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] init];
        _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImgView.layer.masksToBounds = YES;
        _logoImgView.layer.cornerRadius = 5;
        _logoImgView.backgroundColor = UIColor.grayColor;
        _logoImgView.image = [UIImage imageNamed:@"西瓜"];
    }
    return _logoImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = UIColor.purpleColor;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel.alloc init];
        _detailLabel.textColor = UIColor.redColor;
        _detailLabel.numberOfLines = 0;
        _detailLabel.backgroundColor = UIColor.greenColor;
    }
    return _detailLabel;
}

@end


