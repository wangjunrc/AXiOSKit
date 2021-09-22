//
//  _45HeaderView.m
//  AXiOSKit
//
//  Created by axinger on 2021/9/22.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_45HeaderView.h"
@import Masonry;
@implementation _45HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.orangeColor;
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
//            make.left.top.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(300, 300));
//            make.center.mas_equalTo(0);
            
        }];
        
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView.alloc init];
        _imgView.image = [UIImage imageNamed:@"西瓜"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
@end
