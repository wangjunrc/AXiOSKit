//
//  _25CompLayoutCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/11.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutCell.h"

@implementation _25CompLayoutCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self _initUI];
        
    }
    return self;
}

-(void)_initUI {
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 10));
    }];
}
- (UIView *)textView {
    if (!_textView) {
        _textView = [[UIView alloc]init];
        _textView.backgroundColor = UIColor.orangeColor;
    }
    return _textView;
}

@end
