//
//  TableViewCell.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/5/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "TableViewCell.h"
#import "AXiOSKit.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor redColor];
    self.contentView.layer.cornerRadius = 10;
    
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_equalTo(20);
         make.right.equalTo(self).mas_equalTo(-20);
         make.top.equalTo(self).mas_equalTo(20);
         make.bottom.equalTo(self).mas_equalTo(-20);
        
    }];
    
    UILabel *testView = [[UILabel alloc]init];
    testView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:testView];
    testView.text = @"AAA";




    UILabel *testView1 = [[UILabel alloc]init];
    testView1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:testView1];
    testView1.text = @"AAA";


    [testView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [testView1 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    testView.mas_key = @"testView>>>>>>>>";
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
//        make.right.equalTo(testView1.mas_left);
    }];



  testView1.mas_key = @"testView1+++++++++++";

    [testView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(testView.mas_right);
//        make.right.mas_equalTo(-50).priority(MASLayoutPriorityDefaultLow);
  make.right.mas_equalTo(-50);
    }];
    
    
//    UILabel* leftLabel = [[UILabel alloc] init];
//    leftLabel.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:leftLabel];
//    leftLabel.text = @"人做的畜生之事越多，内心越是痛苦。";
//    [leftLabel sizeToFit];
//
//    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
//    UILabel* rightLabel = [[UILabel alloc] init];
//    rightLabel.backgroundColor = [UIColor greenColor];
//    [self.contentView addSubview:rightLabel];
//    rightLabel.text = @"1234567890";
//    [rightLabel sizeToFit];
//
//
//    [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//
//    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(20));
//        make.left.equalTo(self.contentView).offset(10);
//        make.centerY.equalTo(self.contentView);
////        make.right.mas_lessThanOrEqualTo(rightLabel.mas_left);
//    }];
//
//    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(20));
//        make.left.mas_greaterThanOrEqualTo(leftLabel.mas_right);
//        make.right.equalTo(self.contentView).offset(-10);
//        make.centerY.equalTo(leftLabel);
//    }];
    
}
- (void)drawRect:(CGRect)rect {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.clipsToBounds = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    self.contentView.x = 50;
//    self.contentView.width=self.width - 100;
    
    
    
//    self.contentView.layer.masksToBounds = YES;
//    self.contentView.clipsToBounds = YES;
    
    
//
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
