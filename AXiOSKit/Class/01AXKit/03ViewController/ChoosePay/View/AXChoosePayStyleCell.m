//
//  AXChoosePayStyleCell.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXChoosePayStyleCell.h"
#import "UIView+AXFrame.h"
#import "UIImage+AXBundle.h"

@implementation AXChoosePayStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    self.selectImageView.image = [UIImage axBundle_imageNamed:@"ax_checkBox_none"];
    self.selectImageView.highlightedImage = [UIImage axBundle_imageNamed:@"ax_checkBox_select"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    
    [super setSelected:selected animated:animated];
    self.selectImageView.highlighted = selected;
    
    
    
    
}

@end
