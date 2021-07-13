//
//  _39MasonryViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/10.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_11MasonryVC.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
@interface _11MasonryVC ()

@end

@implementation _11MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Masonry 布局";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    
    [self _test1];
    [self _test2];
    
    [self _lastLoadBottomAttribute];
    
}

-(void)_test1 {
    
    UIView *bgView = UIView.alloc.init;
    bgView.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:bgView];
    
    NSArray *dataArray = @[@"0",@"1"];
    
    
    [self _titlelabel:@"数组约束,垂直评价布局"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    
    self.bottomAttribute = bgView.mas_bottom;
    
    NSMutableArray<UIView *> *temp = [NSMutableArray arrayWithCapacity:dataArray.count];

    
    @weakify(temp);
    [dataArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIView *view = UIView.alloc.init;
        view.backgroundColor = UIColor.ax_randomColor;
        
        view.tag = idx;
        @strongify(temp);
        [temp addObject:view];
        view.backgroundColor = [UIColor ax_randomColor];
        [bgView addSubview:view];
    }];
    
    [temp  mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:20 tailSpacing:30];

    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-20);
    }];
    
}

-(void)_test2 {
    [self _titlelabel:@"相对顶部约束"];
    
  
    
    UILabel *label1 = UILabel.alloc.init;
    [self.containerView addSubview:label1];
    label1.numberOfLines  = 0;
    label1.backgroundColor = UIColor.orangeColor;
    label1.text = @"左边-\n\n\n左边";
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(5);
    }];
    
    
    
    UILabel *label2 = UILabel.alloc.init;
    [self.containerView addSubview:label2];
    label2.numberOfLines  = 0;
    label2.backgroundColor = UIColor.purpleColor;
    label2.text = @"右边";
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_top);
        make.left.equalTo(label1.mas_right).mas_offset(40);
    }];
    
    UILabel *label3 = UILabel.alloc.init;
    [self.containerView insertSubview:label3 belowSubview:label1];
    
    label3.numberOfLines  = 0;
    label3.backgroundColor = UIColor.greenColor;
    label3.text = @"底部\n\n\n\n\n\n\n\n底部";
    
    /// 设置内容拥抱优先级
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
   /// 设置内容抗压缩优先级
    [label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    // 抗被压缩
    [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label1.mas_bottom).mas_offset(20);
        make.top.greaterThanOrEqualTo(label1.mas_bottom).mas_offset(20);
        make.top.greaterThanOrEqualTo(label2.mas_bottom).mas_offset(20);
        
        make.left.equalTo(label1.mas_left);
        make.right.equalTo(label2.mas_right);
        
        
    }];
    
    self.bottomAttribute = label3.mas_bottom;
    
    [self _buttonTitle:@"左边单行,右边多行文字" handler:^(UIButton * _Nonnull btn) {
        label1.text = @"左边\n\n\n左边";
        label2.text = @"右边";
    }];
    
    [self _buttonTitle:@"左边多行,右边单行文字" handler:^(UIButton * _Nonnull btn) {
        label1.text = @"左边";
        label2.text = @"右边\n\n\n\n\n\n右边";
    }];
    
}



@end
