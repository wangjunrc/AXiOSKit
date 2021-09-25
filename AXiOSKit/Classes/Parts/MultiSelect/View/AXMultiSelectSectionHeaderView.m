//
//  AXMultiSelectSectionHeaderView.m
//  AXiOSKit
//
//  Created by axing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXMultiSelectSectionHeaderView.h"
#import <Masonry/Masonry.h>
#import "UIColor+AXKit.h"
@implementation AXMultiSelectSectionHeaderView

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 10, 0, 0));
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor ax_colorFromHexString:@"#FFFFFF"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

@end
