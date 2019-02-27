//
//  BView.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/25.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "BView.h"
#import "AView.h"
#import "AXiOSTools.h"
@implementation BView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        AView *bView = [[AView alloc]init];
        [self addSubview:bView];
        
        [bView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
    }
    return self;
}

@end
