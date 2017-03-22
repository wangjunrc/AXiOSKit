//
//  AXNoContentView.m
//  AXTools
//
//  Created by Mole Developer on 2016/10/19.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXNoContentView.h"

@implementation AXNoContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[NSBundle mainBundle]loadNibNamed:@"AXNoContentView" owner:self options:nil].firstObject;
        self.titleLabel = [view viewWithTag:101];
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}

@end
