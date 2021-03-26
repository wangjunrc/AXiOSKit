//
//  _00HeaderView.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/1/26.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_00HeaderView.h"

@implementation _00HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.greenColor;
        [self _initUI];
    }
    return self;
}
-(void)_initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.nameLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
       
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(20);
        make.right.mas_equalTo(-10);
//        make.bottom.equalTo(self).mas_equalTo(-200);
        make.bottom.equalTo(self.mas_bottom).mas_equalTo(-200).priorityMedium();
    }];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.titleLabel.mas_bottom).mas_equalTo(200);
//    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"table headerview高度自适应";
    }
    return _titleLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"nameLabel";
    }
    return _nameLabel;
}
@end
