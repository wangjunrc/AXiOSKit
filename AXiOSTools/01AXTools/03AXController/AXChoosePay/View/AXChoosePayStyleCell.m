//
//  AXChoosePayStyleCell.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXChoosePayStyleCell.h"

@implementation AXChoosePayStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectImageView.highlighted = selected;
    
    // Configure the view for the selected state
}

@end
