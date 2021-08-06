//
//  _41UIStackVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_41UIStackVC.h"
@import Masonry;
@import AXiOSKit;

@interface _41UIStackVC ()

@property(nonatomic,strong)UIView *contentView;


@property(nonatomic,strong)UIStackView *contentStackView;



@end

@implementation _41UIStackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.contentView];
//    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_offset(0);
//        make.bottom.mas_offset(0);
//        make.height.mas_equalTo(200);
//    }];
    
    UIImage *backGroundImage = [UIImage imageNamed:@"nav_bg_img"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    
    
    [self.view addSubview:self.contentStackView];
    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(100);
        } else {
            make.bottom.mas_equalTo(0);
        }
    }];
    // 列数,
    NSUInteger lineNumber = 5;
    NSUInteger plateformCount = 8;
    
    NSUInteger line  =((plateformCount- 1) / lineNumber) + 1;
    
    
    for (NSUInteger idx=0; idx<3; idx++) {
        
        UIStackView *stackView = [UIStackView.alloc init];
        stackView.userInteractionEnabled = YES;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.axis = UILayoutConstraintAxisHorizontal;
        [self.contentStackView addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_offset(200);
        }];
        
        
        for (NSUInteger idx2=0; idx2<6; idx2++) {

            UIView *itemView = UIView.alloc.init;
            itemView.backgroundColor = UIColor.ax_randomColor;
            [stackView addArrangedSubview:itemView];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.height.mas_offset(20);
            }];
        }
        
        
    }
    
    
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        _contentView.backgroundColor = UIColor.purpleColor;
    }
    return _contentView;
}
- (UIStackView *)contentStackView {
    if (!_contentStackView) {
        _contentStackView = [UIStackView.alloc init];
        _contentStackView.userInteractionEnabled = YES;
//        _contentStackView.distribution = UIStackViewDistributionFillEqually;
//        _contentStackView.axis = UILayoutConstraintAxisVertical;
        
        _contentStackView.axis = UILayoutConstraintAxisHorizontal;
        _contentStackView.spacing = 25;
        _contentStackView.distribution = UIStackViewDistributionEqualSpacing;
    }
    return _contentStackView;
}



@end
