//
//  _02CollectionViewCell.m
//  AXiOSKit
//
//  Created by axinger on 2021/9/26.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_02CollectionViewCell.h"

@implementation _02CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self buidUI];
        
    }
    return self;
}


- (void)buidUI {
    self.contentView.backgroundColor = UIColor.orangeColor;
    CGFloat leftMargin = 5;
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.detaLabel];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(leftMargin);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.detaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLabel.mas_bottom).mas_equalTo(5);
        make.left.equalTo(self.nameLabel.mas_left).mas_equalTo(0);
        make.right.mas_equalTo(0);
//        make.width.mas_equalTo(80);
        
        
        make.bottom.mas_equalTo(-leftMargin);
    }];
    
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.image = [UIImage imageNamed:@"西瓜"];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColor.darkTextColor;
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *)detaLabel {
    if (!_detaLabel) {
        _detaLabel = [[UILabel alloc]init];
        _detaLabel.textColor = UIColor.lightTextColor;
        _detaLabel.numberOfLines = 0;
    }
    return _detaLabel;
}



@end
