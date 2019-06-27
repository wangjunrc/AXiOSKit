//
//  AXMultiSelectCell.m
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXMultiSelectCell.h"
#import "UIColor+AXKit.h"
#import <Masonry/Masonry.h>

@interface AXMultiSelectCell ()

@property(nonatomic, strong)UIView *normalContentView;

@property(nonatomic, strong)UIView *selectedContentView;


@end

@implementation AXMultiSelectCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupConstrains];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.normalContentView addSubview:self.titleLabel];
    
    self.backgroundView = self.normalContentView;
    
    self.selectedBackgroundView = self.selectedContentView;
}

- (void)setupConstrains {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        
        self.titleLabel.textColor = [UIColor ax_colorFromHexString:@"#FBB600"];
    }else{
        
        self.titleLabel.textColor = [UIColor ax_colorFromHexString:@"#FFFFFF"];
    }
}

- (UIView *)normalContentView {
    if (!_normalContentView) {
        _normalContentView = [[UIView alloc]init];
        _normalContentView.backgroundColor = [UIColor ax_colorFromHexString:@"#282828"];;
        _normalContentView.layer.cornerRadius = 5;
        _normalContentView.layer.masksToBounds = YES;
    }
    return _normalContentView;
}

- (UIView *)selectedContentView {
    if (!_selectedContentView) {
        _selectedContentView = [[UIView alloc]init];
        _selectedContentView.backgroundColor = [UIColor clearColor];
        _selectedContentView.layer.borderColor = [UIColor ax_colorFromHexString:@"#FBB600"].CGColor;
        _selectedContentView.layer.borderWidth = 1;
        _selectedContentView.layer.cornerRadius = 5;
        _selectedContentView.layer.masksToBounds = YES;
    }
    return _selectedContentView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor ax_colorFromHexString:@"#FFFFFF"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (void)setViewModel:(AXMultiSelectRowViewModel *)viewModel {
    _viewModel = viewModel;
    self.titleLabel.text = viewModel.title;
    
}

@end

