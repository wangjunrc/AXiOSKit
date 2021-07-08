//
//  _14TextFieldVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_14TextFieldVC.h"
@import Masonry;
@import AXiOSKit;

@interface _14TextFieldVC ()



@end

@implementation _14TextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        [self _titlelabel:@"字符长度约束-5个"];
        UITextField *tf = UITextField.alloc.init;
        tf.backgroundColor = UIColor.grayColor;
        [self.containerView addSubview:tf];
        tf.ax_observe.maxTextLength = 5;
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        self.bottomAttribute = tf.mas_bottom;
    }
    
    {
        [self _titlelabel:@"禁止输入空格"];
        UITextField *tf = UITextField.alloc.init;
        tf.backgroundColor = UIColor.grayColor;
        [self.containerView addSubview:tf];
        
        
        tf.ax_observe.banBlankSpace = YES;
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        
        self.bottomAttribute = tf.mas_bottom;
    }
    
    
    
    
    [self _lastLoadBottomAttribute];
}


@end
