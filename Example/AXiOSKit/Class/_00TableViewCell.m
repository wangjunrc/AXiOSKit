//
//  _00TableViewCell.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/7.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_00TableViewCell.h"

@implementation _00TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.numberOfLines = 0;
    self.tintColor = UIColor.greenColor;
    self.backgroundView = [UIView.alloc init];
    
    self.selectedBackgroundView = [[UIView alloc] init];//这句不可省略
    self.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
