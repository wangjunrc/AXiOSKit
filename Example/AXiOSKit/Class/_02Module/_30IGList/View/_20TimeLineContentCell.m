//
//  _20TimeLineContentCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_20TimeLineContentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation _20TimeLineContentCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];

        [self buidUI];
        
    }
    return self;
}


- (void)buidUI {
    
    CGFloat leftMargin = 10;
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(leftMargin);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).mas_equalTo(10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.nameLabel);
        make.right.mas_equalTo(-10);
        
//        make.bottom.mas_equalTo(-50);
    }];
    
    
}

-(void)bindViewModel:(_30TimeLineModel *)vm {
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:vm.lavatar]];
    self.nameLabel.text = vm.luserName;
    self.contentLabel.text = vm.lcontent;
    
}


- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColor.blackColor;
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColor.blackColor;
    }
    return _contentLabel;
}
@end
