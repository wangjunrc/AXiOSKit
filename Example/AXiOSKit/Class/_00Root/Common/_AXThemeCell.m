//
//  _AXThemeCell.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_AXThemeCell.h"
#import <AXiOSKit/UIColor+AXKit.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/NSObject+AXSafe.h>

@implementation _AXThemeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.logoImgView];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        //        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImgView.mas_right).mas_offset(10);
        make.top.equalTo(self.logoImgView.mas_top);
        make.right.mas_equalTo(self).mas_offset(-10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.mas_equalTo(self).mas_offset(-10);
        
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-30);
    }];
}


- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] init];
        _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImgView.layer.masksToBounds = YES;
        _logoImgView.layer.cornerRadius = 5;
        _logoImgView.image = [UIImage imageNamed:@"西瓜"];
    }
    return _logoImgView;
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


- (void)setOption:(AXDataSourceOption *)option {
    _option = option;
    
    self.titleLabel.text = option.title;
    self.detailLabel.text = option.detail;
    if (ax_objc_is_not_empty(option.imgName)) {
        self.logoImgView.image = [UIImage imageNamed:option.imgName];
    }
}
@end


