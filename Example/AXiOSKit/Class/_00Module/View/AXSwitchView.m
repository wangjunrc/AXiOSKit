//
//  AXSwitch.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/15.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXSwitchView.h"

@implementation AXSwitchView


- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(frame.origin.x, frame.origin.y, 100, 30);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.orangeColor;
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self.frame  = CGRectMake( self.frame.origin.x,  self.frame.origin.y, 100, 30);
    if (self = [super initWithCoder:coder]) {
        
        self.autoresizingMask = UIViewAutoresizingNone;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    rect = CGRectMake(rect.origin.x, rect.origin.y, 100, 30);
    [super drawRect:rect];


}
- (void)layoutSubviews {
    NSLog(@"frame = %@",NSStringFromCGRect(self.frame));
    
    
//    self.frame = CGRectMake( self.frame.origin.x,  self.frame.origin.y, 100, 30);
    
    
    
    NSLog(@"frame =2 %@",NSStringFromCGRect(self.frame));
//    [self.widthAnchor constraintEqualToConstant:100].active =YES;
//    [self.heightAnchor constraintEqualToConstant:30].active =YES;
    
    [super layoutSubviews];
    
//     [self.widthAnchor constraintEqualToConstant:100].active =YES;
//     [self.heightAnchor constraintEqualToConstant:30].active =YES;
    
    
    
}


-(void)setFrame:(CGRect)frame {
//    frame = CGRectMake(frame.origin.x, frame.origin.y, 100, 30);
    [super setFrame:frame];
}

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, (bounds.size.height - 5)/2.0, bounds.size.width, 5);
}


@end
