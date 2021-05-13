//
//  _02RootCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/13.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_02RootCell.h"

@interface _02RootCell ()


@end

@implementation _02RootCell

+ (CGFloat)cellHeight {
    return 90;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gameImg.layer.cornerRadius = 5;
    self.statusBtn.layer.cornerRadius = 5;
}

#pragma mark - Public Methods


#pragma mark - Initize Methods

- (void)initUI {
    
    {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
        
        self.gameImg = iv;
        [self.contentView addSubview:iv];
    }
    
    {
        UILabel *lab = [[UILabel alloc]init];
        [lab setTextColor:[UIColor blackColor]];
        
        self.titleLab = lab;
        [self.contentView addSubview:lab];
    }
    
    {
        UILabel *lab = [[UILabel alloc]init];
        
        self.timeLab = lab;
        [self.contentView addSubview:lab];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.statusBtn = btn;
        [self.contentView addSubview:btn];
    }
    
    [self.gameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.width.mas_equalTo(self.gameImg.mas_height).multipliedBy(1.4);
    }];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gameImg.mas_right).mas_offset(15);
        make.top.mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-20);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-40);
    }];
    
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gameImg.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.timeLab.mas_bottom).mas_offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(20);
        
        make.bottom.equalTo(self.contentView.mas_bottom).mas_equalTo(-60);
    }];
    self.titleLab.text = [NSString stringWithFormat:@"鬼灭之刃第%@集",@"1"];
    self.timeLab.text = @"发布时间：2018-09-12";
    [self.gameImg setImage:[UIImage imageNamed:@"200x100"]];
    
    [self.statusBtn setTitle:@"未观看" forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:[UIColor grayColor]];
}

@end

