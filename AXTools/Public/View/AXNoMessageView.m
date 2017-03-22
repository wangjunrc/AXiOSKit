//
//  AXNoMessageView.m
//  AXTools
//
//  Created by Mole Developer on 16/10/11.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXNoMessageView.h"

@implementation AXNoMessageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[NSBundle mainBundle]loadNibNamed:@"AXNoMessageView" owner:self options:nil].firstObject;
        
        self.imageView = [view viewWithTag:101];

        self.titleLabel = [view viewWithTag:201];
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}
@end
