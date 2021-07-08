//
//  _00TableViewCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_00TableViewCell.h"

@implementation _00TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI {
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tintColor = UIColor.redColor;
    self.backgroundView = [UIView.alloc init];
    
    self.backgroundView.backgroundColor = [UIColor ax_colorWithNormalStyle:[UIColor ax_colorFromHexString:@"0x99ffff"] darkStyle:UIColor.blackColor];
    
    self.selectedBackgroundView = [[UIView alloc] init];//这句不可省略
    //    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView.backgroundColor = UIColor.grayColor;
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_lessThanOrEqualTo(-10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);;
        make.right.mas_lessThanOrEqualTo(-10);
        
        make.bottom.equalTo(self.contentView.mas_bottom).mas_equalTo(-20);
    }];
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.textColor = [UIColor ax_colorWithNormalStyle:UIColor.blackColor darkStyle:UIColor.whiteColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel.alloc init];
        _detailLabel.textColor = [UIColor ax_colorWithNormalStyle:UIColor.blackColor darkStyle:UIColor.whiteColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}


@end
