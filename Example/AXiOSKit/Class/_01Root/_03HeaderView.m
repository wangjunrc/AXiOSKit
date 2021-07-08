//
//  _03HeaderView.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/3/25.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_03HeaderView.h"

@implementation _03HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

-(void)_initUI{
    self.backgroundColor = UIColor.purpleColor;
    [self addSubview:self.bgImgView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
        make.bottom.mas_equalTo(-50);
    }];
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.image = [UIImage imageNamed:@"exporte"];
    }
    return _bgImgView;
}


@end
