//
//  RigImageButton.m
//  Financing118
//
//  Created by Mole Developer on 16/2/24.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "RigImageButton.h"

@implementation RigImageButton

- (void)layoutSubviews{//左文字,右图片
    [super layoutSubviews];
    
    CGFloat labelWidth = self.titleLabel.width;
    CGFloat imageWith = self.imageView.width;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state{

    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
