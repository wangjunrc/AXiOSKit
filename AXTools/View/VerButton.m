//
//  VerButton.m
//  AXTools
//
//  Created by Mole Developer on 16/6/21.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "VerButton.h"

@implementation VerButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = CGRectGetMaxY(self.imageView.frame);
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    
    
//    self.imageView.y = 2;
//    self.imageView.x = (self.width-self.imageView.width)/2;
//    
//    self.imageView.height = self.height-self.titleLabel.height-2;
////    self.imageView.width = self.height-self.titleLabel.height;
//    
//    
//    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
//    
//    self.titleLabel.x = (self.width-self.titleLabel.width)/2;
//    self.titleLabel.width =  self.titleLabel.width;
//    self.titleLabel.height =  self.titleLabel.height;
    
//      NSDictionary *attributes = @{NSFontAttributeName:self.titleLabel.font};
//    CGSize size1 = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    self.titleEdgeInsets =UIEdgeInsetsMake(0.5*self.imageView.size.height, -0.5*self.imageView.size.width, -0.5*self.imageView.size.height, 0.5*self.imageView.size.width);
//    self.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
}
@end
